//
//  DateTableViewCell.swift
//  TodoListApp
//
//  Created by Barış Uyar on 18.12.2017.
//  Copyright © 2017 Barış Uyar. All rights reserved.
//

import UIKit

class DateTableViewCell: UITableViewCell {

    var taskDateButton = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTaskDateButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTaskDateButton() {
        contentView.addSubview(taskDateButton)
        taskDateButton.translatesAutoresizingMaskIntoConstraints = false
        taskDateButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        taskDateButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        taskDateButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        taskDateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        taskDateButton.backgroundColor = UIColor.blue.withAlphaComponent(0.55)
        taskDateButton.setTitle("Tarih Seç", for: .normal)
        taskDateButton.layer.masksToBounds = true
        taskDateButton.layer.cornerRadius = 10 
    }
    
}
