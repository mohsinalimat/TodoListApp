//
//  TaskViewController.swift
//  TodoListApp
//
//  Created by Barış Uyar on 18.12.2017.
//  Copyright © 2017 Barış Uyar. All rights reserved.
//

import UIKit
import CoreData
import EventKit

class TaskViewController: UIViewController {
    
    var barColor = UIColor(red: 19 / 255, green: 167 / 255, blue: 89 / 255, alpha: 1)
    var tableView = UITableView()
    let welcomeLabel = UILabel()
    let welcomeView = UIView()
    
    var tasks: [Task] = []

    override func viewDidLoad() {
        self.title = "Görevlerim"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.white.withAlphaComponent(1)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        navigationItem.setRightBarButton(doneButton, animated: false)
        self.navigationController?.navigationBar.barTintColor = barColor
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getTasks {
            complete in
            if tasks.count >= 1 {
                tableView.isHidden = false
                welcomeView.removeFromSuperview()
                welcomeLabel.removeFromSuperview()
                tableView.reloadData()
            }
            else {
                tableView.isHidden = true
                self.view.addSubview(welcomeView)
                welcomeView.translatesAutoresizingMaskIntoConstraints = false
                welcomeView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                welcomeView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                welcomeView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
                welcomeView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
                welcomeView.backgroundColor = UIColor.white
                
                self.welcomeView.addSubview(welcomeLabel)
                welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
                welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                welcomeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                welcomeLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 7 / 8).isActive = true
                welcomeLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
                welcomeLabel.font = UIFont(name: "Helvetica", size: 25)
                welcomeLabel.text = "TodoApp'e Hoşgeldiniz"
                welcomeLabel.textColor = barColor
                welcomeLabel.textAlignment = .center
            }
        }
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
    @objc func addTask() {
        let vc = AddTaskViewController()
        vc.toUpdate = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getTasks(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        
        do {
            tasks = try managedContext.fetch(fetchRequest)
            completion(true)
        } catch {
            debugPrint(error.localizedDescription)
            completion(false)
        }
    }
    
    func removeTask(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        managedContext.delete(tasks[indexPath.row])
        do {
            try managedContext.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func addCalendar(atIndexPath indexPath: IndexPath) {
        let eventStore: EKEventStore = EKEventStore()
        eventStore.requestAccess(to: .event) {
            granted, error in
            if granted && error == nil {
                let event: EKEvent = EKEvent(eventStore: eventStore)
                event.title = self.tasks[indexPath.row].name
                event.startDate = Date()
                event.endDate = self.tasks[indexPath.row].date
                event.notes = self.tasks[indexPath.row].note
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch _ as NSError{
                    let alert = UIAlertController(title: "Takvime Ekle", message: "Aynı gün içinde bitecek işlerinizi takvime eklemeyiniz.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Kapat", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            } else {
                print(error?.localizedDescription)
            }
        }
    }
}


extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = TaskTableViewCell()
        if tasks[indexPath.row].priority == 0 {
            taskCell.priorityView.backgroundColor = UIColor.red
        } else if tasks[indexPath.row].priority == 1 {
            taskCell.priorityView.backgroundColor = UIColor.yellow
        } else if tasks[indexPath.row].priority == 2 {
            taskCell.priorityView.backgroundColor = UIColor.green
        }
        taskCell.configureCell(task: tasks[indexPath.row])
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Sil") {
            rowAction, indexPath in
            self.removeTask(atIndexPath: indexPath)
            self.getTasks {
                complete in
                if self.tasks.count >= 1 {
                    tableView.isHidden = false
                    self.welcomeView.removeFromSuperview()
                    self.welcomeLabel.removeFromSuperview()
                    tableView.reloadData()
                }
                else {
                    tableView.isHidden = true
                    self.view.addSubview(self.welcomeView)
                    self.welcomeView.translatesAutoresizingMaskIntoConstraints = false
                    self.welcomeView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                    self.welcomeView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                    self.welcomeView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
                    self.welcomeView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
                    self.welcomeView.backgroundColor = UIColor.white
                    
                    self.welcomeView.addSubview(self.welcomeLabel)
                    self.welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
                    self.welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                    self.welcomeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                    self.welcomeLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 4 / 5).isActive = true
                    self.welcomeLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
                    self.welcomeLabel.font = UIFont(name: "Helvetica", size: 25)
                    self.welcomeLabel.text = "TodoApp'e Hoşgeldiniz"
                    self.welcomeLabel.textColor = self.barColor
                    self.welcomeLabel.textAlignment = .center
                }
            }
        }
        deleteAction.backgroundColor = UIColor.red
        
        let calenderAction = UITableViewRowAction(style: .normal, title: "Takvim") {
            rowAction, indexPath in
            self.addCalendar(atIndexPath: indexPath)
        }
        calenderAction.backgroundColor = UIColor(red: 253 / 255, green: 185 / 255, blue: 44 / 255, alpha: 1)
        
        let callAction = UITableViewRowAction(style: .normal, title: "SMS") {
            rowAction, indexPath in
            let vc = SMSViewController()
            vc.task = self.tasks[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        callAction.backgroundColor = self.barColor
        return [deleteAction, calenderAction, callAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddTaskViewController()
        vc.task = tasks[indexPath.row]
        vc.toUpdate = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

