//
//  DiveLogSegment.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/16/21.
//

import UIKit

class DiveLogSegment: UISegmentedControl {
    
    let type: DiveLogInputType
    var index: Int = 0
    
    init(type: DiveLogInputType) {
        self.type = type
        super.init(frame: .zero)
        setSegmentOptions(type: type)
        self.selectedSegmentTintColor = .systemSecondary
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        self.addTarget(self, action: #selector(setSelection), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setSegmentOptions(type: DiveLogInputType) {
        switch type {
        case .diveType:
            for (index, type) in DiveType.allCases.enumerated() {
                self.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .waterType:
            for (index, type) in WaterType.allCases.enumerated() {
                self.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .waterBody:
            for (index, type) in WaterBody.allCases.enumerated() {
                self.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .diveWeather:
            for (index, type) in DiveWeather.allCases.enumerated() {
                self.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .diveVisibility:
            for (index, type) in DiveVisibility.allCases.enumerated() {
                self.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .waves:
            for (index, type) in Waves.allCases.enumerated() {
                self.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .current:
            for (index, type) in Current.allCases.enumerated() {
                self.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .surge:
            for (index, type) in Surge.allCases.enumerated() {
                self.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .suitType:
            for (index, type) in SuitType.allCases.enumerated() {
                self.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .tankType:
            for (index, type) in TankType.allCases.enumerated() {
                self.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .gasMixture:
            for (index, type) in GasMixture.allCases.enumerated() {
                self.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        }
        
        self.selectedSegmentIndex = 0
    }
    
    @objc func setSelection() {
        index = self.selectedSegmentIndex
    }
    
    func setSegmentIndex(dive: DiveModel) {
        switch type {
        case .diveType:
            self.index = Int(dive.diveType)
        case .waterType:
            self.index = Int(dive.waterType)
        case .waterBody:
            self.index = Int(dive.waterBody)
        case .diveWeather:
            self.index = Int(dive.diveWeather)
        case .diveVisibility:
            self.index = Int(dive.visibility)
        case .waves:
            self.index = Int(dive.waves)
        case .current:
            self.index = Int(dive.current)
        case .surge:
            self.index = Int(dive.surge)
        case .suitType:
            self.index = Int(dive.suitType)
        case .tankType:
            self.index = Int(dive.tankType)
        case .gasMixture:
            self.index = Int(dive.gasMixture)
        }
        selectedSegmentIndex = index
    }
}
