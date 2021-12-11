//
//  DiveLogPicker.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/16/21.
//

import UIKit
import CoreData

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
    
    func setPickerValue(dive: DiveModel) {
        switch type {
        case .suit:
            self.index = Int(dive.suitType)
        case .gas:
            self.index = Int(dive.gasMixture)
        }
        self.selectRow(self.index, inComponent: 0, animated: false)
    }
    
    func getValue() -> Int {
        return self.selectedRow(inComponent: 0)
    }
}
