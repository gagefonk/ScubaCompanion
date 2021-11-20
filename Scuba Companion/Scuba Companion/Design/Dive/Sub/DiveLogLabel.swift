//
//  DiveLogLabel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/16/21.
//

import UIKit

class DiveLogLabel: UILabel {
    
    init(text: String, style: UIFont.TextStyle) {
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont.preferredFont(forTextStyle: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
