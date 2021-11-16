//
//  DiveViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/9/21.
//

import Foundation
import UIKit

enum AddSave {
    case add
    case save
}

class DiveViewModel {
    
    let diveForms = DiveLogForms()
    let diveCards: [DiveLogFormCard]
    let diveLogVM: DiveLogViewModel
    let index: Int?
    
    init(diveLogViewModel: DiveLogViewModel, index: Int?) {
        self.diveLogVM = diveLogViewModel
        diveCards = diveForms.formCards
        self.index = index
        loadDiveInfo(index: index)
    }
    
    private func loadDiveInfo(index: Int?) {
        guard let index = index else { return }
        let dive = diveLogVM.dives[index]
        //load dive info
        for card in diveCards {
            switch card.id {
            case "title":
                card.inputField.text = dive.title
            case "site":
                card.inputField.text = dive.site
            case "date":
                card.datePicker.date = dive.date
            case "diveType":
                card.segmentControl.selectedSegmentIndex = getIndexFromInputType(dive: dive, inputType: .diveType)
            case "maxDepth":
                card.inputField.text = dive.maxDepth
            case "bottomTime":
                card.inputField.text = dive.diveLength
            case "waterType":
                card.segmentControl.selectedSegmentIndex = getIndexFromInputType(dive: dive, inputType: .waterType)
            case "waterBody":
                card.segmentControl.selectedSegmentIndex = getIndexFromInputType(dive: dive, inputType: .waterBody)
            case "weather":
                card.segmentControl.selectedSegmentIndex = getIndexFromInputType(dive: dive, inputType: .diveWeather)
            case "airTemp":
                card.inputField.text = dive.airTemp
            case "surfaceTemp":
                card.inputField.text = dive.surfaceTemp
            case "bottomTemp":
                card.inputField.text = dive.bottomTemp
            case "visibility":
                card.segmentControl.selectedSegmentIndex = getIndexFromInputType(dive: dive, inputType: .diveVisibility)
            case "visibilityDistance":
                card.inputField.text = dive.visibilityInMeters
            case "wave":
                card.segmentControl.selectedSegmentIndex = getIndexFromInputType(dive: dive, inputType: .waves)
            case "current":
                card.segmentControl.selectedSegmentIndex = getIndexFromInputType(dive: dive, inputType: .current)
            case "surge":
                card.segmentControl.selectedSegmentIndex = getIndexFromInputType(dive: dive, inputType: .surge)
            case "suitType":
                card.segmentControl.selectedSegmentIndex = getIndexFromInputType(dive: dive, inputType: .suitType)
            case "weight":
                card.inputField.text = dive.weight
            case "tankType":
                card.segmentControl.selectedSegmentIndex = getIndexFromInputType(dive: dive, inputType: .tankType)
            case "tankUnits":
                card.inputField.text = dive.tankSize
            case "gas":
                card.segmentControl.selectedSegmentIndex = getIndexFromInputType(dive: dive, inputType: .gasMixture)
            case "oxygen":
                card.inputField.text = dive.oxygen
            case "nitrogen":
                card.inputField.text = dive.nitrogen
            case "helium":
                card.inputField.text = dive.helium
            case "startPressure":
                card.inputField.text = dive.startPressure
            case "endPressure":
                card.inputField.text = dive.endPressure
            case "diveBuddy":
                card.inputField.text = dive.diveBuddy
            case "diveCenter":
                card.inputField.text = dive.diveCenter
            case "note":
                card.inputField.text = dive.note
            default:
                break
            }
        }
    }
    
    func createDiveLog(with addOrSave: AddSave, index: Int?, completion: (NotificationErrorType?)->Void) {
        let title: String = getUserInputValues(id: "title")
        let site: String = getUserInputValues(id: "site")
        let date: Date = getDateValue(id: "date")
        let diveType: DiveType = getSegmentSelection(id: "diveType", segmentType: .diveType) as! DiveType
        let maxDepth: String = getUserInputValues(id: "maxDepth")
        let diveLength: String = getUserInputValues(id: "bottomTime")
        let waterType: WaterType = getSegmentSelection(id: "waterType", segmentType: .waterType) as! WaterType
        let waterBody: WaterBody = getSegmentSelection(id: "waterBody", segmentType: .waterBody) as! WaterBody
        let diveWeather: DiveWeather = getSegmentSelection(id: "weather", segmentType: .diveWeather) as! DiveWeather
        let airTemp: String = getUserInputValues(id: "airTemp")
        let surfaceTemp: String = getUserInputValues(id: "surfaceTemp")
        let bottomTemp: String = getUserInputValues(id: "bottomTemp")
        let visibility: DiveVisibility = getSegmentSelection(id: "visibility", segmentType: .diveVisibility) as! DiveVisibility
        let visibilityInMeters: String = getUserInputValues(id: "visibilityDistance")
        let waves: Waves = getSegmentSelection(id: "wave", segmentType: .waves) as! Waves
        let current: Current = getSegmentSelection(id: "current", segmentType: .current) as! Current
        let surge: Surge = getSegmentSelection(id: "surge", segmentType: .surge) as! Surge
        let suitType: SuitType = getSegmentSelection(id: "suitType", segmentType: .suitType) as! SuitType
        let weight: String = getUserInputValues(id: "weight")
        let tankType: TankType = getSegmentSelection(id: "tankType", segmentType: .tankType) as! TankType
        let tankSize: String = getUserInputValues(id: "tankUnits")
        let gasMixture: GasMixture = getSegmentSelection(id: "gas", segmentType: .gasMixture) as! GasMixture
        let oxygen: String = getUserInputValues(id: "oxygen")
        let nitrogen: String = getUserInputValues(id: "nitrogen")
        let helium: String = getUserInputValues(id: "helium")
        let startPressure: String = getUserInputValues(id: "startPressure")
        let endPressure: String = getUserInputValues(id: "endPressure")
        let amountUsed: String = getAmountUsed(start: startPressure, end: endPressure)
        let note: String = getUserInputValues(id: "note")
        let diveBuddy: String = getUserInputValues(id: "diveBuddy")
        let diveCenter: String = getUserInputValues(id: "diveCenter")
        
        if isTitleBlank(title: title) {
            let err: NotificationErrorType = .missingTitle
            completion(err)
            return
        }
        
        let dive = Dive(title: title, site: site, date: date, diveType: diveType, maxDepth: maxDepth, diveLength: diveLength, waterType: waterType, waterBody: waterBody, diveWeather: diveWeather, airTemp: airTemp, surfaceTemp: surfaceTemp, bottomTemp: bottomTemp, visibility: visibility, visibilityInMeters: visibilityInMeters, waves: waves, current: current, surge: surge, suitType: suitType, weight: weight, tankType: tankType, tankSize: tankSize, gasMixture: gasMixture, oxygen: oxygen, nitrogen: nitrogen, helium: helium, startPressure: startPressure, endPressure: endPressure, amountUsed: amountUsed, note: note, diveBuddy: diveBuddy, diveCenter: diveCenter)
        
        switch addOrSave {
        case .add:
            diveLogVM.addDive(dive: dive)
            completion(nil)
        case .save:
            //dont forget to throw error later
            guard let index = index else {
                return
            }
            diveLogVM.saveDive(dive: dive, index: index)
            completion(nil)
        }
    }
    
    private func getUserInputValues(id: String) -> String {
        guard let card = diveCards.first(where: {$0.id == id}) else { return ""}
        guard let value = card.inputField.text else { return ""}
        return value
    }
    
    private func getDateValue(id: String) -> Date {
        guard let card = diveCards.first(where: {$0.id == id}) else { return Date()}
        return card.datePicker.date
    }
    
    private func getSegmentSelection(id: String, segmentType: DiveLogInputType) -> Any {
        guard let card = diveCards.first(where: {$0.id == id}) else { return 0}
        let index = card.segmentControl.selectedSegmentIndex
        let val = card.segmentControl.titleForSegment(at: index)
        return getType(val: val!, type: segmentType)
    }
    
    private func getAmountUsed(start: String, end: String) -> String {
        let startInt = Int(start) ?? 0
        let endInt = Int(end) ?? 0
        return String(startInt - endInt)
    }
    
    private func getType(val: String, type: DiveLogInputType) -> Any? {
        switch type {
        case .diveType:
            return DiveType(rawValue: val)
        case .waterType:
            return WaterType(rawValue: val)
        case .waterBody:
            return WaterBody(rawValue: val)
        case .diveWeather:
            return DiveWeather(rawValue: val)
        case .diveVisibility:
            return DiveVisibility(rawValue: val)
        case .waves:
            return Waves(rawValue: val)
        case .current:
            return Current(rawValue: val)
        case .surge:
            return Surge(rawValue: val)
        case .suitType:
            return SuitType(rawValue: val)
        case .tankType:
            return TankType(rawValue: val)
        case .gasMixture:
            return GasMixture(rawValue: val)
        }
    }
    
    private func getCurrentDiveDate(dive: Dive?) -> Date {
        return dive?.date ?? Date()
    }
    
    private func getIndexFromInputType(dive: Dive?, inputType: DiveLogInputType) -> Int {
        var indexInt = 0
        switch inputType {
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
        }
        return indexInt
    }
    
    private func isTitleBlank(title: String) -> Bool {
        return title == ""
    }

}
