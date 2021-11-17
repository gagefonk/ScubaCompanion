//
//  DiveLogPicker.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/16/21.
//

import UIKit

class DiveLogPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let type: DivePickerType
    var index: Int = 0
    
    init(type: DivePickerType) {
        self.type = type
        
        super.init(frame: .zero)
        
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch type {
        case .suit:
            return SuitType.allCases.count
        case .gas:
            return GasMixture.allCases.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch type {
        case .suit:
            return SuitType.allCases[row].rawValue
        case .gas:
            return GasMixture.allCases[row].rawValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        index = row
    }
    
    func setPickerValue(dive: Dive) {
        switch type {
        case .suit:
            for (index, type) in SuitType.allCases.enumerated() where type == dive.suitType {
                self.index = index
            }
        case .gas:
            for (index, type) in GasMixture.allCases.enumerated() where type == dive.gasMixture {
                self.index = index
            }
        }
        self.selectRow(self.index, inComponent: 0, animated: false)
    }
    
    func getValue() -> Any {
        switch type {
        case .suit:
            return SuitType.allCases[index]
        case .gas:
            return GasMixture.allCases[index]
        }
    }
}
