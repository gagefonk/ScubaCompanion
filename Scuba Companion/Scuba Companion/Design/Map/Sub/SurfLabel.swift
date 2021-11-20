//
//  SurfLabel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/17/21.
//

import UIKit

class SurfLabel: UILabel {
    
    init(text: String, style: UIFont.TextStyle, color: UIColor?) {
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont.preferredFont(forTextStyle: style)
        self.textColor = color ?? .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
