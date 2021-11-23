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
                card.inputField?.text = dive.title
            case "site":
                card.inputField?.text = dive.site
            case "date":
                card.datePicker?.date = dive.date
            case "diveType":
                card.segmentControl?.getIndexFromInputType(dive: dive)
            case "maxDepth":
                card.slider?.setValue(dive.maxDepth, animated: true)
                card.sliderLabel?.text = String(card.slider?.value ?? 0)
            case "bottomTime":
                card.slider?.setValue(dive.diveLength, animated: true)
                card.sliderLabel?.text = String(card.slider?.value ?? 0)
            case "waterType":
                card.segmentControl?.getIndexFromInputType(dive: dive)
            case "waterBody":
                card.segmentControl?.getIndexFromInputType(dive: dive)
            case "weather":
                card.segmentControl?.getIndexFromInputType(dive: dive)
            case "airTemp":
                card.slider?.setValue(dive.airTemp, animated: true)
                card.sliderLabel?.text = String(card.slider?.value ?? 0)
            case "surfaceTemp":
                card.slider?.setValue(dive.surfaceTemp, animated: true)
                card.sliderLabel?.text = String(card.slider?.value ?? 0)
            case "bottomTemp":
                card.slider?.setValue(dive.bottomTemp, animated: true)
                card.sliderLabel?.text = String(card.slider?.value ?? 0)
            case "visibility":
                card.segmentControl?.getIndexFromInputType(dive: dive)
            case "visibilityDistance":
                card.slider?.setValue(dive.visibilityInMeters, animated: true)
                card.sliderLabel?.text = String(card.slider?.value ?? 0)
            case "wave":
                card.segmentControl?.getIndexFromInputType(dive: dive)
            case "current":
                card.segmentControl?.getIndexFromInputType(dive: dive)
            case "surge":
                card.segmentControl?.getIndexFromInputType(dive: dive)
            case "suitType":
                card.optionPicker?.setPickerValue(dive: dive)
            case "weight":
                card.slider?.setValue(dive.weight, animated: true)
                card.sliderLabel?.text = String(card.slider?.value ?? 0)
            case "tankType":
                card.segmentControl?.getIndexFromInputType(dive: dive)
            case "tankUnits":
                card.slider?.setValue(dive.tankSize, animated: true)
                card.sliderLabel?.text = String(card.slider?.value ?? 0)
            case "gas":
                card.optionPicker?.setPickerValue(dive: dive)
            case "oxygen":
                card.slider?.setValue(dive.oxygen, animated: true)
                card.sliderLabel?.text = String(card.slider?.value ?? 0)
            case "nitrogen":
                card.slider?.setValue(dive.nitrogen, animated: true)
                card.sliderLabel?.text = String(card.slider?.value ?? 0)
            case "helium":
                card.slider?.setValue(dive.helium, animated: true)
                card.sliderLabel?.text = String(card.slider?.value ?? 0)
            case "startPressure":
                card.slider?.setValue(dive.startPressure, animated: true)
                card.sliderLabel?.text = String(card.slider?.value ?? 0)
            case "endPressure":
                card.slider?.setValue(dive.endPressure, animated: true)
                card.sliderLabel?.text = String(card.slider?.value ?? 0)
            case "diveBuddy":
                card.inputField?.text = dive.diveBuddy
            case "diveCenter":
                card.inputField?.text = dive.diveCenter
            case "note":
                card.inputField?.text = dive.note
            default:
                break
            }
        }
    }
    
    func createDiveLog(with addOrSave: AddSave, index: Int?, completion: (DiveError?)->Void) {
        let title: String = getUserInputValues(id: "title")
        let site: String = getUserInputValues(id: "site")
        let date: Date = getDateValue(id: "date")
        let diveType: DiveType = getSegmentSelection(id: "diveType") as! DiveType
        let maxDepth: Float = getSliderValue(id: "maxDepth")
        let diveLength: Float = getSliderValue(id: "bottomTime")
        let waterType: WaterType = getSegmentSelection(id: "waterType") as! WaterType
        let waterBody: WaterBody = getSegmentSelection(id: "waterBody") as! WaterBody
        let diveWeather: DiveWeather = getSegmentSelection(id: "weather") as! DiveWeather
        let airTemp: Float = getSliderValue(id: "airTemp")
        let surfaceTemp: Float = getSliderValue(id: "surfaceTemp")
        let bottomTemp: Float = getSliderValue(id: "bottomTemp")
        let visibility: DiveVisibility = getSegmentSelection(id: "visibility") as! DiveVisibility
        let visibilityInMeters: Float = getSliderValue(id: "visibilityDistance")
        let waves: Waves = getSegmentSelection(id: "wave") as! Waves
        let current: Current = getSegmentSelection(id: "current") as! Current
        let surge: Surge = getSegmentSelection(id: "surge") as! Surge
        let suitType: SuitType = getPickerOption(id: "suitType") as! SuitType
        let weight: Float = getSliderValue(id: "weight")
        let tankType: TankType = getSegmentSelection(id: "tankType") as! TankType
        let tankSize: Float = getSliderValue(id: "tankUnits")
        let gasMixture: GasMixture = getPickerOption(id: "gas") as! GasMixture
        let oxygen: Float = getSliderValue(id: "oxygen")
        let nitrogen: Float = getSliderValue(id: "nitrogen")
        let helium: Float = getSliderValue(id: "helium")
        let startPressure: Float = getSliderValue(id: "startPressure")
        let endPressure: Float = getSliderValue(id: "endPressure")
        let amountUsed: Float = getAmountUsed(start: startPressure, end: endPressure)
        let note: String = getUserInputValues(id: "note")
        let diveBuddy: String = getUserInputValues(id: "diveBuddy")
        let diveCenter: String = getUserInputValues(id: "diveCenter")
        
        if isTitleBlank(title: title) {
            let err: DiveError = .title
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
        guard let value = card.inputField?.text else { return ""}
        return value
    }
    
    private func getSliderValue(id: String) -> Float {
        guard let card = diveCards.first(where: {$0.id == id}) else { return 0}
        return card.slider?.value ?? 0
    }
    
    private func getDateValue(id: String) -> Date {
        guard let card = diveCards.first(where: {$0.id == id}) else { return Date()}
        return card.datePicker?.date ?? Date()
    }
    
    private func getSegmentSelection(id: String) -> Any {
        guard let card = diveCards.first(where: {$0.id == id}) else { return 0}
        return card.segmentControl?.getSelectedSegment()
    }
    
    private func getPickerOption(id: String) -> Any {
        guard let card = diveCards.first(where: {$0.id == id}) else { return 0}
        return card.optionPicker?.getValue()
    }
    
    private func getAmountUsed(start: Float, end: Float) -> Float {
        return start - end
    }
    
    private func getCurrentDiveDate(dive: Dive?) -> Date {
        return dive?.date ?? Date()
    }
    
    
    
    private func isTitleBlank(title: String) -> Bool {
        return title == ""
    }

}
