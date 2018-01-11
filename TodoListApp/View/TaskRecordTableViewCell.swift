//
//  TaskRecordTableViewCell.swift
//  TodoListApp
//
//  Created by Barış Uyar on 19.12.2017.
//  Copyright © 2017 Barış Uyar. All rights reserved.
//

import UIKit

class TaskRecordTableViewCell: UITableViewCell {
    
    var recordButton = UIButton()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupRecordButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupRecordButton() {
        contentView.addSubview(recordButton)
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        recordButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        recordButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let recordButtonBGColor = UIColor(red: 20 / 255, green: 152 / 255, blue: 43 / 255, alpha: 1)
        recordButton.backgroundColor = recordButtonBGColor
        recordButton.setTitleColor(UIColor.white, for: .normal)
        recordButton.layer.masksToBounds = true
        recordButton.layer.cornerRadius = 10
    }

}
