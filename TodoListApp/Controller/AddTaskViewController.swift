//
//  AddTaskViewController.swift
//  TodoListApp
//
//  Created by Barış Uyar on 18.12.2017.
//  Copyright © 2017 Barış Uyar. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate
class AddTaskViewController: UIViewController {
    
    var task = Task()
    var tableView = UITableView()
    var datePicker: UDatePicker!
    var date = Date()
    var taskDate = Date()
    
    var taskTypeString = TaskType.Aktivite.rawValue
    var taskPriorityString = Priority.onemli.rawValue
    var taskNameString = ""
    var taskNoteString = ""
    var taskTypeInt = 0
    var taskPriorityInt = 0
    var toUpdate: Bool = Bool()

    override func viewDidLoad() {
        if toUpdate {
            self.title = "Görevi Güncelle"
        } else {
            self.title = "Görev Ekle"
        }
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupTableView()
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    @objc func showDatePicker(_ sender: UIButton) {
        
        if datePicker == nil {
            let picker = UDatePicker(frame: view.frame, willDisappear: {date in
                if let date = date {
                    self.date = date
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .short
                    
                    dateFormatter.locale = Locale(identifier: "tr")
                    
                    sender.setTitle(dateFormatter.string(from: date), for: UIControlState())
                    self.taskDate = date
                }
            })
            
            picker.picker.datePicker.minimumDate = Date()
            picker.picker.doneButton.setTitle("Tarihi Seç", for: UIControlState())
            
            datePicker = picker
        }
        datePicker.picker.date = date
        datePicker.present(self)
    }
    
    @objc func recordTask() {
        if toUpdate {
            guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
            let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
            let predicate = NSPredicate(format: "taskID == %@", task.taskID!)
            
            fetchRequest.predicate = predicate
            do {
                let test = try managedContext.fetch(fetchRequest)
                if test.count == 1 {
                    let task = test[0]
                    task.date = taskDate
                    task.name = taskNameString
                    task.note = taskNoteString
                    task.priority = Int32(taskPriorityInt)
                    task.type = Int32(taskTypeInt)
                    do {
                        try managedContext.save()
                    } catch {
                        debugPrint(error.localizedDescription)
                    }
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
            self.navigationController?.popViewController(animated: true)
        } else {
        let uuid = NSUUID().uuidString
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let task = Task(context: managedContext)
        task.taskID = uuid
        task.name = taskNameString
        task.note = taskNoteString
        task.date = taskDate
        task.type = Int32(taskTypeInt)
        task.priority = Int32(taskPriorityInt)
        
        do {
            try managedContext.save()
            print("Kayıt edildi")
        } catch {
            debugPrint(error.localizedDescription)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

}

extension AddTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let cell = DateTableViewCell()
            cell.taskDateButton.addTarget(self, action: #selector(showDatePicker(_:)), for: .touchUpInside)
            if toUpdate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                
                dateFormatter.locale = Locale(identifier: "tr")
                cell.taskDateButton.setTitle(dateFormatter.string(from: task.date!), for: .normal)
            }
            return cell
        } else if indexPath.section == 4 {
            let cell = TaskTypeTableViewCell()
            cell.taskTypePicker.pickerView.delegate = self
            cell.taskTypePicker.pickerView.dataSource = self
            if toUpdate {
                if task.type == 0 {
                    cell.taskTypePicker.text = TaskType.Aktivite.rawValue
                    cell.taskTypePicker.pickerView.selectRow(Int(task.type), inComponent: 0, animated: false)
                    taskTypeInt = Int(task.type)
                    taskTypeString = TaskType.Aktivite.rawValue
                } else if task.type == 1 {
                    cell.taskTypePicker.text = TaskType.Is.rawValue
                    cell.taskTypePicker.pickerView.selectRow(Int(task.type), inComponent: 0, animated: false)
                    taskTypeInt = Int(task.type)
                    taskTypeString = TaskType.Is.rawValue
                } else {
                    cell.taskTypePicker.text = TaskType.Okul.rawValue
                    cell.taskTypePicker.pickerView.selectRow(Int(task.type), inComponent: 0, animated: false)
                    taskTypeInt = Int(task.type)
                    taskTypeString = TaskType.Okul.rawValue
                }
            } else {
            cell.taskTypePicker.text = taskTypeString
            }
            cell.taskTypePicker.delegate = self
            return cell
        }else if indexPath.section == 3 {
            let cell = TaskPriorityTableViewCell()
            cell.taskPriorityPicker.pickerView.delegate = self
            cell.taskPriorityPicker.pickerView.delegate = self
            if toUpdate {
                if task.type == 0 {
                    cell.taskPriorityPicker.text = Priority.onemli.rawValue
                    cell.taskPriorityPicker.pickerView.selectRow(Int(task.type), inComponent: 0, animated: false)
                    taskPriorityInt = Int(task.priority)
                    taskPriorityString = Priority.onemli.rawValue
                } else if task.type == 1 {
                    cell.taskPriorityPicker.text = Priority.orta.rawValue
                    cell.taskPriorityPicker.pickerView.selectRow(Int(task.type), inComponent: 0, animated: false)
                    taskPriorityInt = Int(task.priority)
                    taskPriorityString = Priority.orta.rawValue
                } else {
                    cell.taskPriorityPicker.text = Priority.onemsiz.rawValue
                    cell.taskPriorityPicker.pickerView.selectRow(Int(task.type), inComponent: 0, animated: false)
                    taskPriorityInt = Int(task.priority)
                    taskPriorityString = Priority.onemsiz.rawValue
                }
            } else {
                cell.taskPriorityPicker.text = taskPriorityString
            }
            cell.taskPriorityPicker.delegate = self
            return cell
        } else if indexPath.section == 0 {
            let cell = TaskNameTableViewCell()
            cell.taskNameTF.tag = 3
            if toUpdate {
                cell.taskNameTF.text = task.name
            }
            cell.taskNameTF.placeholder = "Görev Adı..."
            cell.taskNameTF.delegate = self
            return cell
        } else if indexPath.section == 1 {
            let cell = TaskNoteTableViewCell()
            if toUpdate {
                cell.taskNoteTV.text = task.note
            }
            cell.taskNoteTV.delegate = self
            return cell
        } else if indexPath.section == 5 {
            let cell = TaskRecordTableViewCell()
            cell.recordButton.addTarget(self, action: #selector(recordTask), for: .touchUpInside)
            if toUpdate {
                cell.recordButton.setTitle("Görevi Güncelle", for: .normal)
            } else {
                cell.recordButton.setTitle("Görev Ekle", for: .normal)
            }
            return cell 
        } else {
        return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 || indexPath.section == 4 || indexPath.section == 3 || indexPath.section == 5{
            return 70
        } else if indexPath.section == 0 {
            return 50
        } else if indexPath.section == 1 {
            return 170
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Görev Adı"
        } else if section == 1 {
            return "Görev Not"
        } else if section == 2 {
            return "Görev Bitiş Tarihi"
        } else if section == 3 {
            return "Görev Önem Değeri"
        } else if section == 4 {
            return "Görev Tipi"
        } else if section == 5 {
            return "Görevi Kayıt Et"
        } else {
            return ""
        }
    }
    
}

extension AddTaskViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TaskType.Okul.hashValue + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 2 {
        if row == 0 {
            return TaskType.Aktivite.rawValue
        } else if row == 1 {
            return TaskType.Is.rawValue
        } else {
            return TaskType.Okul.rawValue
        }
        } else {
            if row == 0 {
                return Priority.onemli.rawValue
            } else if row == 1 {
                return Priority.orta.rawValue
            } else {
                return Priority.onemsiz.rawValue
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 2 {
        if row == 0 {
            taskTypeString = TaskType.Aktivite.rawValue
            taskTypeInt = TaskType.Aktivite.hashValue
        } else if row == 1 {
            taskTypeString = TaskType.Is.rawValue
            taskTypeInt = TaskType.Is.hashValue
        } else {
            taskTypeString = TaskType.Okul.rawValue
            taskTypeInt = TaskType.Okul.hashValue
        }
        } else if pickerView.tag == 1 {
            if row == 0 {
                taskPriorityString = Priority.onemli.rawValue
                taskPriorityInt = Priority.onemli.hashValue
            } else if row == 1 {
                taskPriorityString = Priority.orta.rawValue
                taskPriorityInt = Priority.orta.hashValue
            } else {
                taskPriorityString = Priority.onemsiz.rawValue
                taskPriorityInt = Priority.onemsiz.hashValue
            }
        }
    }
    
}

extension AddTaskViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            textField.text = taskPriorityString
        } else if textField.tag == 2 {
            textField.text = taskTypeString
        } else if textField.tag == 3 {
            taskNameString = textField.text!
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddTaskViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension AddTaskViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        taskNoteString = textView.text
    }
}
