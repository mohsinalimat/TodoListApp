//
//  TaskTableViewCell.swift
//  TodoListApp
//
//  Created by Barış Uyar on 18.12.2017.
//  Copyright © 2017 Barış Uyar. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    var backView = UIView()
    var priorityView = UIView()
    var taskNameLabel = UILabel()
    var taskDateLabel = UILabel()
    var taskTypeLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.34)
        setupbackView()
        setupPriorityView()
        setupTaskNameLabel()
        setuptaskDateLabel()
        setupTaskTypeLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupbackView() {
        contentView.addSubview(backView)
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        backView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 9 / 10).isActive = true
        backView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 8 / 9).isActive = true
        backView.backgroundColor = UIColor.white
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 10
    }
    
    func setupPriorityView() {
        backView.addSubview(priorityView)
        priorityView.translatesAutoresizingMaskIntoConstraints = false
        priorityView.leftAnchor.constraint(equalTo: backView.leftAnchor).isActive = true
        priorityView.topAnchor.constraint(equalTo: backView.topAnchor).isActive = true
        priorityView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        priorityView.heightAnchor.constraint(equalTo: backView.heightAnchor).isActive = true
        priorityView.layer.masksToBounds = true
        priorityView.layer.cornerRadius = 10
        priorityView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func setupTaskNameLabel() {
        backView.addSubview(taskNameLabel)
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        taskNameLabel.leftAnchor.constraint(equalTo: priorityView.rightAnchor, constant: 5).isActive = true
        taskNameLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5).isActive = true
        taskNameLabel.widthAnchor.constraint(equalTo: backView.widthAnchor, constant: -15).isActive = true
        taskNameLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        taskNameLabel.font = UIFont(name: "Helvetica", size: 20)
        taskNameLabel.text = "Burası Görev Adı"
    }
    
    func setuptaskDateLabel() {
        backView.addSubview(taskDateLabel)
        taskDateLabel.translatesAutoresizingMaskIntoConstraints = false
        taskDateLabel.leftAnchor.constraint(equalTo: taskNameLabel.leftAnchor).isActive = true
        taskDateLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 5).isActive = true
        taskDateLabel.widthAnchor.constraint(equalTo: taskNameLabel.widthAnchor).isActive = true
        taskDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        taskDateLabel.font = UIFont(name: "Helvetica", size: 16)
        taskDateLabel.text = "Burası Görev Tarihi"
        taskDateLabel.textColor = UIColor.red
    }
    
    func setupTaskTypeLabel() {
        backView.addSubview(taskTypeLabel)
        taskTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        taskTypeLabel.leftAnchor.constraint(equalTo: taskNameLabel.leftAnchor).isActive = true
        taskTypeLabel.topAnchor.constraint(equalTo: taskDateLabel.bottomAnchor, constant: 5).isActive = true
        taskTypeLabel.widthAnchor.constraint(equalTo: taskNameLabel.widthAnchor).isActive = true
        taskTypeLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        taskTypeLabel.font = UIFont(name: "Helvetica", size: 18)
        taskTypeLabel.text = "Burası Görev Tarihi"
    }
    
    func configureCell(name: String, type: TaskType, date: Date) {
        self.taskNameLabel.text = name
        self.taskTypeLabel.text = type.rawValue
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "tr")
        self.taskDateLabel.text = dateFormatter.string(from: date)
    }
    
    func configureCell(task: Task) {
        self.taskNameLabel.text = task.name
        if task.type == 0 {
            self.taskTypeLabel.text = TaskType.Aktivite.rawValue
        } else if task.type == 1 {
            self.taskTypeLabel.text = TaskType.Is.rawValue
        } else {
            self.taskTypeLabel.text = TaskType.Okul.rawValue
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "tr")
        self.taskDateLabel.text = dateFormatter.string(from: task.date!)
    }
}
