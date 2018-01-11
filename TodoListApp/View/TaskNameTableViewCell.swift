//
//  TaskNameTableViewCell.swift
//  TodoListApp
//
//  Created by Barış Uyar on 19.12.2017.
//  Copyright © 2017 Barış Uyar. All rights reserved.
//

import UIKit

class TaskNameTableViewCell: UITableViewCell {
    
    var taskNameTF = UITextField()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTaskNameTF()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTaskNameTF() {
        contentView.addSubview(taskNameTF)
        taskNameTF.translatesAutoresizingMaskIntoConstraints = false
        taskNameTF.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        taskNameTF.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        taskNameTF.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        taskNameTF.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
}
