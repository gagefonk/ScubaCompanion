//
//  DiveLog.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/9/21.
//

import Foundation

enum DiveLogGroup {
    case input
    case date
    case typeInput
}

struct DiveLogCard {
    let group: DiveLogGroup
    let inputType: LogInputTypes
    let textType: CharType
    let title: String
    let subtitle: String
    let placeholder: String
    let units: String
    
    //input init
    init(group: DiveLogGroup, textType: CharType, title: String, subtitle: String, placeholder: String, units: String) {
        self.group = group
        self.textType = textType
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.units = units
        self.inputType = .none
    }
    
    //date init
    init(group: DiveLogGroup, title: String, subtitle: String) {
        self.group = group
        self.textType = .none
        self.title = title
        self.subtitle = subtitle
        self.placeholder = ""
        self.units = ""
        self.inputType = .none
    }
    
    //date init
    init(group: DiveLogGroup, inputType: LogInputTypes, title: String, subtitle: String) {
        self.group = group
        self.textType = .none
        self.title = title
        self.subtitle = subtitle
        self.placeholder = ""
        self.units = ""
        self.inputType = inputType
    }
}
