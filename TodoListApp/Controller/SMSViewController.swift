//
//  SMSViewController.swift
//  TodoListApp
//
//  Created by Barış Uyar on 19.12.2017.
//  Copyright © 2017 Barış Uyar. All rights reserved.
//

import UIKit
import MessageUI

class SMSViewController: UIViewController {
    
    var smsControllerView = UIView()
    var numberTF = UITextField()
    var task = Task()
    
    var smsSendButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupSmsControllerView()
        setupNumberTF()
        setupSmsSendButton()
    }
    
    func setupSmsControllerView() {
        self.view.addSubview(smsControllerView)
        smsControllerView.translatesAutoresizingMaskIntoConstraints = false
        smsControllerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        smsControllerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        smsControllerView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        smsControllerView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        smsControllerView.backgroundColor = UIColor.white
    }

    func setupNumberTF() {
        self.smsControllerView.addSubview(numberTF)
        numberTF.translatesAutoresizingMaskIntoConstraints = false
        numberTF.centerXAnchor.constraint(equalTo: self.smsControllerView.centerXAnchor).isActive = true
        numberTF.topAnchor.constraint(equalTo: self.smsControllerView.topAnchor, constant: 50).isActive = true
        numberTF.widthAnchor.constraint(equalTo: self.smsControllerView.widthAnchor, multiplier: 3 / 5).isActive = true
        numberTF.heightAnchor.constraint(equalToConstant: 30).isActive = true
        numberTF.keyboardType = .phonePad
        numberTF.placeholder = "Telefon No"
        numberTF.delegate = self
    }
    
    func setupSmsSendButton() {
        self.smsControllerView.addSubview(smsSendButton)
        smsSendButton.translatesAutoresizingMaskIntoConstraints = false
        smsSendButton.centerXAnchor.constraint(equalTo: self.smsControllerView.centerXAnchor).isActive = true
        smsSendButton.topAnchor.constraint(equalTo: self.numberTF.bottomAnchor, constant: 10).isActive = true
        smsSendButton.widthAnchor.constraint(equalTo: self.numberTF.widthAnchor).isActive = true
        smsSendButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        smsSendButton.setTitle("SMS Yolla", for: .normal)
        let vc = TaskViewController()
        smsSendButton.backgroundColor = vc.barColor
        smsSendButton.setTitleColor(UIColor.white, for: .normal)
        smsSendButton.addTarget(self, action: #selector(sendSMS), for: .touchUpInside)
    }
    
    @objc func sendSMS() {
        if MFMessageComposeViewController.canSendText() {
            let vc = MFMessageComposeViewController()
            vc.body = task.name! + " " + task.note!
            vc.recipients = [numberTF.text!]
            vc.messageComposeDelegate = self
            self.present(vc, animated: true, completion: nil)
        } else {
            print("hata")
        }
    }
}

extension SMSViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 11
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SMSViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SMSViewController: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}
