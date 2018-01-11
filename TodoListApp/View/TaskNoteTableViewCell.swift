//
//  TaskNoteTableViewCell.swift
//  TodoListApp
//
//  Created by Barış Uyar on 19.12.2017.
//  Copyright © 2017 Barış Uyar. All rights reserved.
//

import UIKit

class TaskNoteTableViewCell: UITableViewCell {

    var taskNoteTV = UITextView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTaskNoteTV()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTaskNoteTV() {
        contentView.addSubview(taskNoteTV)
        taskNoteTV.translatesAutoresizingMaskIntoConstraints = false
        taskNoteTV.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        taskNoteTV.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        taskNoteTV.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 7/8).isActive = true
        taskNoteTV.heightAnchor.constraint(equalToConstant: 150).isActive = true
        taskNoteTV.font = UIFont(name: "Helvetica", size: 14)
    }
}
