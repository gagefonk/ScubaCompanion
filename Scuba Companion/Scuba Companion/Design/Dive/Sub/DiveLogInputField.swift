//
//  DiveLogInputField.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/16/21.
//

import UIKit

class DiveLogInputField: UITextField, UITextFieldDelegate {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
        self.backgroundColor = .clear
        self.borderStyle = .roundedRect
        self.textColor = .white
        self.leftViewMode = .always
        self.rightViewMode = .always
        self.isUserInteractionEnabled = true
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
}
