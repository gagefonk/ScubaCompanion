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
    
    func getSelectedSegment() -> Any? {
        switch type {
        case .diveType:
            return DiveType.allCases[self.selectedSegmentIndex]
        case .waterType:
            return WaterType.allCases[self.selectedSegmentIndex]
        case .waterBody:
            return WaterBody.allCases[self.selectedSegmentIndex]
        case .diveWeather:
            return DiveWeather.allCases[self.selectedSegmentIndex]
        case .diveVisibility:
            return DiveVisibility.allCases[self.selectedSegmentIndex]
        case .waves:
            return Waves.allCases[self.selectedSegmentIndex]
        case .current:
            return Current.allCases[self.selectedSegmentIndex]
        case .surge:
            return Surge.allCases[self.selectedSegmentIndex]
        case .suitType:
            return SuitType.allCases[self.selectedSegmentIndex]
        case .tankType:
            return TankType.allCases[self.selectedSegmentIndex]
        case .gasMixture:
            return GasMixture.allCases[self.selectedSegmentIndex]
        }
    }
    
    func getIndexFromInputType(dive: Dive) {
        switch type {
        case .diveType:
            for (index, type) in DiveType.allCases.enumerated() where type == dive.diveType {
                self.index = index
            }
        case .waterType:
            for (index, type) in WaterType.allCases.enumerated() where type == dive.waterType {
                self.index = index
            }
        case .waterBody:
            for (index, type) in WaterBody.allCases.enumerated() where type == dive.waterBody {
                self.index = index
            }
        case .diveWeather:
            for (index, type) in DiveWeather.allCases.enumerated() where type == dive.diveWeather {
                self.index = index
            }
        case .diveVisibility:
            for (index, type) in DiveVisibility.allCases.enumerated() where type == dive.visibility {
                self.index = index
            }
        case .waves:
            for (index, type) in Waves.allCases.enumerated() where type == dive.waves {
                self.index = index
            }
        case .current:
            for (index, type) in Current.allCases.enumerated() where type == dive.current {
                self.index = index
            }
        case .surge:
            for (index, type) in Surge.allCases.enumerated() where type == dive.surge {
                self.index = index
            }
        case .suitType:
            for (index, type) in SuitType.allCases.enumerated() where type == dive.suitType {
                self.index = index
            }
        case .tankType:
            for (index, type) in TankType.allCases.enumerated() where type == dive.tankType {
                self.index = index
            }
        case .gasMixture:
            for (index, type) in GasMixture.allCases.enumerated() where type == dive.gasMixture {
                self.index = index
            }
        }
        setSelection()
    }
}
