//
//  DiveViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/9/21.
//

import Foundation
import UIKit

class DiveViewModel {
    
    let diveForms = DiveLogForms()
    var diveCards: [UIView] = []
    let diveLogVM: DiveLogViewModel
    
    init(diveLogViewModel: DiveLogViewModel, dive: Dive?) {
        self.diveLogVM = diveLogViewModel
        populateFormCards(diveFormData: diveForms.forms, dive: dive)
    }
    
    private func populateFormCards(diveFormData: [DiveLogCard], dive: Dive?) {
        
        diveFormData.forEach { form in
            switch form.group {
            case .input:
                let cardView = DiveLogInputCard()
                cardView.configureCard(charType: form.textType, title: form.title, subtitle: form.subtitle, units: form.units, placeholder: form.placeholder)
                cardView.inputField.text = getCurrentDiveText(dive: dive, form: form)
                diveCards.append(cardView)
            case .date:
                let cardView = DiveLogDateCard()
                cardView.configureCard(title: form.title, subtitle: form.subtitle)
                cardView.datePicker.setDate(getCurrentDiveDate(dive: dive), animated: true)
                diveCards.append(cardView)
            case .typeInput:
                let cardView = DiveLogTypeCard()
                cardView.configureCard(title: form.title, subtitle: form.subtitle, type: form.inputType)
                cardView.segmentControl.selectedSegmentIndex = getCurrentTypeSelection(dive: dive, form: form)
                diveCards.append(cardView)
            }
        }
        
    }
    
    //get data from forms fields and create dive
    func createDiveLog(inputs: [String], date: Date, segments: [String]) {
        let amountUsed = getAmountUsed(start: inputs[13], end: inputs[14])
        let diveType = getType(val: segments[0], type: .diveType) as! DiveType
        let waterType = getType(val: segments[1], type: .waterType) as! WaterType
        let waterBody = getType(val: segments[2], type: .waterBody) as! WaterBody
        let diveWeather = getType(val: segments[3], type: .diveWeather) as! DiveWeather
        let diveVisibility = getType(val: segments[4], type: .diveVisibility) as! DiveVisibility
        let waves = getType(val: segments[5], type: .waves) as! Waves
        let current = getType(val: segments[6], type: .current) as! Current
        let surge = getType(val: segments[7], type: .surge) as! Surge
        let suitType = getType(val: segments[8], type: .suitType) as! SuitType
        let tankType = getType(val: segments[9], type: .tankType) as! TankType
        let gasMixture = getType(val: segments[10], type: .gasMixture) as! GasMixture
        
        let dive = Dive(title: inputs[0], site: inputs[1], date: date, diveType: diveType, maxDepth: inputs[2], diveLength: inputs[3], waterType: waterType, waterBody: waterBody, diveWeather: diveWeather, airTemp: inputs[4], surfaceTemp: inputs[5], bottomTemp: inputs[6], visibility: diveVisibility, visibilityInMeters: inputs[7], waves: waves, current: current, surge: surge, suitType: suitType, weight: inputs[8], tankType: tankType, tankSize: inputs[9], gasMixture: gasMixture, oxygen: inputs[10], nitrogen: inputs[11], helium: inputs[12], startPressure: inputs[13], endPressure: inputs[14], amountUsed: amountUsed, note: inputs[15], diveBuddy: inputs[16], diveCenter: inputs[17])
        
        diveLogVM.addDive(dive: dive)
    }
    
    //get data from forms fields and save dive
    func saveDiveLog(inputs: [String], date: Date, segments: [String], index: Int) {
        let amountUsed = getAmountUsed(start: inputs[13], end: inputs[14])
        let diveType = getType(val: segments[0], type: .diveType) as! DiveType
        let waterType = getType(val: segments[1], type: .waterType) as! WaterType
        let waterBody = getType(val: segments[2], type: .waterBody) as! WaterBody
        let diveWeather = getType(val: segments[3], type: .diveWeather) as! DiveWeather
        let diveVisibility = getType(val: segments[4], type: .diveVisibility) as! DiveVisibility
        let waves = getType(val: segments[5], type: .waves) as! Waves
        let current = getType(val: segments[6], type: .current) as! Current
        let surge = getType(val: segments[7], type: .surge) as! Surge
        let suitType = getType(val: segments[8], type: .suitType) as! SuitType
        let tankType = getType(val: segments[9], type: .tankType) as! TankType
        let gasMixture = getType(val: segments[10], type: .gasMixture) as! GasMixture
        
        let dive = Dive(title: inputs[0], site: inputs[1], date: date, diveType: diveType, maxDepth: inputs[2], diveLength: inputs[3], waterType: waterType, waterBody: waterBody, diveWeather: diveWeather, airTemp: inputs[4], surfaceTemp: inputs[5], bottomTemp: inputs[6], visibility: diveVisibility, visibilityInMeters: inputs[7], waves: waves, current: current, surge: surge, suitType: suitType, weight: inputs[8], tankType: tankType, tankSize: inputs[9], gasMixture: gasMixture, oxygen: inputs[10], nitrogen: inputs[11], helium: inputs[12], startPressure: inputs[13], endPressure: inputs[14], amountUsed: amountUsed, note: inputs[15], diveBuddy: inputs[16], diveCenter: inputs[17])
        
        diveLogVM.saveDive(dive: dive, index: index)
    }
    
    private func getAmountUsed(start: String, end: String) -> String {
        let startInt = Int(start) ?? 0
        let endInt = Int(end) ?? 0
        return String(startInt - endInt)
    }
    
    private func getType(val: String, type: LogInputTypes) -> Any? {
        switch type {
        case .diveType:
            return DiveType(rawValue: val)!
        case .waterType:
            return WaterType(rawValue: val)!
        case .waterBody:
            return WaterBody(rawValue: val)!
        case .diveWeather:
            return DiveWeather(rawValue: val)!
        case .diveVisibility:
            return DiveVisibility(rawValue: val)!
        case .waves:
            return Waves(rawValue: val)!
        case .current:
            return Current(rawValue: val)!
        case .surge:
            return Surge(rawValue: val)!
        case .suitType:
            return SuitType(rawValue: val)!
        case .tankType:
            return TankType(rawValue: val)!
        case .gasMixture:
            return GasMixture(rawValue: val)!
        case .none:
            return nil
        }
    }
    
    private func getCurrentDiveText(dive: Dive?, form: DiveLogCard) -> String {
        if form.id == "title" {
            return dive?.title ?? ""
        }
        else if form.id == "site" {
            return dive?.site ?? ""
        }
        else if form.id == "maxDepth" {
            return dive?.maxDepth ?? ""
        }
        else if form.id == "bottomTime" {
            return dive?.diveLength ?? ""
        }
        else if form.id == "airTemp" {
            return dive?.airTemp ?? ""
        }
        else if form.id == "surfaceTemp" {
            return dive?.surfaceTemp ?? ""
        }
        else if form.id == "bottomTemp" {
            return dive?.bottomTemp ?? ""
        }
        else if form.id == "visibilityDistance" {
            return dive?.visibilityInMeters ?? ""
        }
        else if form.id == "weight" {
            return dive?.weight ?? ""
        }
        else if form.id == "tankUnits" {
            return dive?.tankSize ?? ""
        }
        else if form.id == "oxygen" {
            return dive?.oxygen ?? ""
        }
        else if form.id == "nitrogen" {
            return dive?.nitrogen ?? ""
        }
        else if form.id == "helium" {
            return dive?.helium ?? ""
        }
        else if form.id == "startPressure" {
            return dive?.startPressure ?? ""
        }
        else if form.id == "endPressure" {
            return dive?.endPressure ?? ""
        }
        else if form.id == "diveBuddy" {
            return dive?.diveBuddy ?? ""
        }
        else if form.id == "diveCenter" {
            return dive?.diveCenter ?? ""
        }
        else if form.id == "note" {
            return dive?.note ?? ""
        }
        else {
            return ""
        }
    }
    
    private func getCurrentDiveDate(dive: Dive?) -> Date {
        return dive?.date ?? Date()
    }
    
    private func getCurrentTypeSelection(dive: Dive?, form: DiveLogCard) -> Int {
        var indexInt = 0
        switch form.inputType {
        case .diveType:
            for (index, type) in DiveType.allCases.enumerated() where type == dive?.diveType {
                indexInt = index
            }
        case .waterType:
            for (index, type) in WaterType.allCases.enumerated() where type == dive?.waterType {
                indexInt = index
            }
        case .waterBody:
            for (index, type) in WaterBody.allCases.enumerated() where type == dive?.waterBody {
                indexInt = index
            }
        case .diveWeather:
            for (index, type) in DiveWeather.allCases.enumerated() where type == dive?.diveWeather {
                indexInt = index
            }
        case .diveVisibility:
            for (index, type) in DiveVisibility.allCases.enumerated() where type == dive?.visibility {
                indexInt = index
            }
        case .waves:
            for (index, type) in Waves.allCases.enumerated() where type == dive?.waves {
                indexInt = index
            }
        case .current:
            for (index, type) in Current.allCases.enumerated() where type == dive?.current {
                indexInt = index
            }
        case .surge:
            for (index, type) in Surge.allCases.enumerated() where type == dive?.surge {
                indexInt = index
            }
        case .suitType:
            for (index, type) in SuitType.allCases.enumerated() where type == dive?.suitType {
                indexInt = index
            }
        case .tankType:
            for (index, type) in TankType.allCases.enumerated() where type == dive?.tankType {
                indexInt = index
            }
        case .gasMixture:
            for (index, type) in GasMixture.allCases.enumerated() where type == dive?.gasMixture {
                indexInt = index
            }
        case .none:
            break
        }
        return indexInt
    }
}
