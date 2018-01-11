//
//  TaskPriorityTableViewCell.swift
//  TodoListApp
//
//  Created by Barış Uyar on 19.12.2017.
//  Copyright © 2017 Barış Uyar. All rights reserved.
//

import UIKit

class TaskPriorityTableViewCell: UITableViewCell {

    var taskPriorityPicker = TaskPriorityPicker()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTaskPriorityPicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTaskPriorityPicker() {
        contentView.addSubview(taskPriorityPicker)
        taskPriorityPicker.translatesAutoresizingMaskIntoConstraints = false
        taskPriorityPicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        taskPriorityPicker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        taskPriorityPicker.widthAnchor.constraint(equalToConstant: 200).isActive = true
        taskPriorityPicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
