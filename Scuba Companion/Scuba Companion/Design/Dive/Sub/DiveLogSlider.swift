//
//  DiveLogSlider.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/16/21.
//

import UIKit

class DiveLogSlider: UISlider {
    
    let type: DiveSliderType
    
    init(type: DiveSliderType) {
        self.type = type
        super.init(frame: .zero)
        
        let (minV, maxV) = setOptions()
        self.minimumValue = minV
        self.maximumValue = maxV
        self.setValue(((minV + maxV) / 2).rounded(), animated: true)
        self.maximumTrackTintColor = .systemSecondary
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setOptions() -> (Float, Float) {
        switch type {
        case .maxDepth:
            return (0, 200)
        case .time:
            return (0, 120)
        case .temp:
            return (0, 90)
        case .vis:
            return (0, 100)
        case .weight:
            return (0, 50)
        case .tank:
            return (30, 100)
        case .gas:
            return (0, 100)
        case .pressure:
            return (0, 4000)
        }
    }
}
