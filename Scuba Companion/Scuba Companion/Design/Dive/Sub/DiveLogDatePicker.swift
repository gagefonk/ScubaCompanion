//
//  DiveLogDatePicker.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/16/21.
//

import UIKit

class DiveLogDatePicker: UIDatePicker {
    
    init() {
        super.init(frame: .zero)
        self.preferredDatePickerStyle = .inline
        self.datePickerMode = .date
        self.tintColor = .systemSecondary
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
