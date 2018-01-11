//
//  TaskTyoePicker.swift
//  TodoListApp
//
//  Created by Barış Uyar on 18.12.2017.
//  Copyright © 2017 Barış Uyar. All rights reserved.
//

import UIKit

class TaskTypePicker: UITextField {

    var pickerView = UIPickerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        self.layer.cornerRadius = 10
        self.textColor = UIColor.white
        self.placeholder = "Tip"
        let str = NSAttributedString(string: "Görev Tipi", attributes: [NSAttributedStringKey.foregroundColor:UIColor.darkGray])
        self.attributedPlaceholder = str
        self.textAlignment = .center
        self.tag = 2
        
        pickerView.tag = 2
        pickerView.selectRow(0, inComponent: 0, animated: false)
        self.inputView = pickerView
        CreateToolbar()
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func CreateToolbar() {
        let toolbar = UIToolbar()
        toolbar.barTintColor = UIColor.blue.withAlphaComponent(0.4)
        
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Tamam", style: .plain, target: self, action: #selector(DoneClicked))
        doneButton.tintColor = UIColor.white
        
        let label = UILabel()
        label.text = "Görev Tipi"
        label.textColor = UIColor.white
        
        let barButtonLabel = UIBarButtonItem(customView: label)
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([doneButton, spaceButton, barButtonLabel], animated: true)
        
        self.inputAccessoryView = toolbar
    }
    
    @objc func DoneClicked() {
        self.resignFirstResponder()
        
        //print("Merhaba burası membertypePicker" + self.text!)
        
    }
}



