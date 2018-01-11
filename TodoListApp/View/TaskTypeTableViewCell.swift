//
//  TaskTypeTableViewCell.swift
//  TodoListApp
//
//  Created by Barış Uyar on 18.12.2017.
//  Copyright © 2017 Barış Uyar. All rights reserved.
//

import UIKit

class TaskTypeTableViewCell: UITableViewCell {
    
    var taskTypePicker = TaskTypePicker()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTextTypePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTextTypePicker() {
        contentView.addSubview(taskTypePicker)
        taskTypePicker.translatesAutoresizingMaskIntoConstraints = false
        taskTypePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        taskTypePicker.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        taskTypePicker.widthAnchor.constraint(equalToConstant: 200).isActive = true
        taskTypePicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
}
