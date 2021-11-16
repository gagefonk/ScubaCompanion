//
//  DiveLogCell.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/8/21.
//

import UIKit

final class DiveLogCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
