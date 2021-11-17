//
//  DiveLogForms.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/10/21.
//

import Foundation

enum DiveLogType {
    case input, slider, date, segment, picker
}


struct DiveLogForms {
    var formCards: [DiveLogFormCard] = []

    init() {
        let titleCard = DiveLogFormCard(diveLogType: .input, title: "Dive Title", subtitle: "What is the title?", units: "", placeholder: "Add title", id: "title")
        let diveSiteCard = DiveLogFormCard(diveLogType: .input, title: "Dive Site", subtitle: "Where did you dive?", units: "", placeholder: "Add site", id: "site")
        let dateCard = DiveLogFormCard(diveLogType: .date, isDate: true, title: "Date", subtitle: "When was the dive?", id: "date")
        let diveTypeCard = DiveLogFormCard(diveLogType: .segment, title: "Dive Type", subtitle: "How did you get in the water?", segmentType: .diveType, id: "diveType")
        let maxDepthCard = DiveLogFormCard(diveLogType: .slider, title: "Max Depth", subtitle: "How deep did you go?", units: "ft", sliderType: .maxDepth, id: "maxDepth")
        let bottomTimeCard = DiveLogFormCard(diveLogType: .slider, title: "Bottom Time", subtitle: "How long were you down for?", units: "min", sliderType: .time, id: "bottomTime")
        let waterTypeCard = DiveLogFormCard(diveLogType: .segment, title: "Water Type", subtitle: "Fresh or salt water?", segmentType: .waterType, id: "waterType")
        let waterBodyCard = DiveLogFormCard(diveLogType: .segment, title: "Body of Water", subtitle: "What body of water did you dive in?", segmentType: .waterBody, id: "waterBody")
        let weatherCard = DiveLogFormCard(diveLogType: .segment, title: "Dive Weather", subtitle: "What was the weather like?", segmentType: .diveWeather, id: "weather")
        let airTempCard = DiveLogFormCard(diveLogType: .slider, title: "Air Temperature", subtitle: "What was the air temperature?", units: "F", sliderType: .temp, id: "airTemp")
        let surfaceTempCard = DiveLogFormCard(diveLogType: .slider, title: "Surface Temperature", subtitle: "What was the surface temperature?", units: "F", sliderType: .temp, id: "surfaceTemp")
        let bottomTempCard = DiveLogFormCard(diveLogType: .slider, title: "Bottom Temperature", subtitle: "What was the bottom temperature?", units: "F", sliderType: .temp, id: "bottomTemp")
        let visibilityCard = DiveLogFormCard(diveLogType: .segment, title: "Visibility", subtitle: "What was the visibility like?", segmentType: .diveVisibility, id: "visibility")
        let visibilityDistanceCard = DiveLogFormCard(diveLogType: .slider, title: "Visibility", subtitle: "How far could you see?", units: "ft", sliderType: .vis, id: "visibilityDistance")
        let waveCard = DiveLogFormCard(diveLogType: .segment, title: "Waves", subtitle: "How were the waves?", segmentType: .waves, id: "wave")
        let currentCard = DiveLogFormCard(diveLogType: .segment, title: "Current", subtitle: "How was the current?", segmentType: .current, id: "current")
        let surgeCard = DiveLogFormCard(diveLogType: .segment, title: "Surge", subtitle: "How was the surge?", segmentType: .surge, id: "surge")
        let suitCard = DiveLogFormCard(diveLogType: .picker, title: "Suit Type", subtitle: "What suit did you wear?", pickerType: .suit, id: "suitType")
        let weightCard = DiveLogFormCard(diveLogType: .slider, title: "Weight", subtitle: "How much weight did you have?", units: "lbs", sliderType: .weight, id: "weight")
        let tankTypeCard = DiveLogFormCard(diveLogType: .segment, title: "Tank", subtitle: "What tank did you dive with?", segmentType: .tankType, id: "tankType")
        let tankUnitCard = DiveLogFormCard(diveLogType: .slider, title: "Tank Units", subtitle: "What was the cylinder size?", units: "L", sliderType: .tank, id: "tankUnits")
        let gasCard = DiveLogFormCard(diveLogType: .picker, title: "Gas Mixture", subtitle: "What kind of gas did you use?", pickerType: .gas, id: "gas")
        let oxygenCard = DiveLogFormCard(diveLogType: .slider, title: "Oxygen", subtitle: "", units: "%", sliderType: .gas, id: "oxygen")
        let nitrogenCard = DiveLogFormCard(diveLogType: .slider, title: "Nitrogen", subtitle: "", units: "%", sliderType: .gas, id: "nitrogen")
        let heliumCard = DiveLogFormCard(diveLogType: .slider, title: "Helium", subtitle: "", units: "%", sliderType: .gas, id: "helium")
        let startPressureCard = DiveLogFormCard(diveLogType: .slider, title: "Start Pressure", subtitle: "What was the starting pressure?", units: "PSI", sliderType: .pressure, id: "startPressure")
        let endPressureCard = DiveLogFormCard(diveLogType: .slider, title: "End Pressure", subtitle: "What was the ending pressure?", units: "PSI", sliderType: .pressure, id: "endPressure")
        let diveBuddyCard = DiveLogFormCard(diveLogType: .input, title: "Dive Buddy", subtitle: "Who did you dive with?", units: "", placeholder: "Add dive buddy", id: "diveBuddy")
        let diveCenterCard = DiveLogFormCard(diveLogType: .input, title: "Dive Center", subtitle: "Did you go with a dive center?", units: "", placeholder: "Add dive center", id: "diveCenter")
        let noteCard = DiveLogFormCard(diveLogType: .input, title: "Notes", subtitle: "Any notes you'd like to add?", units: "", placeholder: "Add note", id: "note")

        formCards.append(titleCard)
        formCards.append(diveSiteCard)
        formCards.append(dateCard)
        formCards.append(diveTypeCard)
        formCards.append(maxDepthCard)
        formCards.append(bottomTimeCard)
        formCards.append(waterTypeCard)
        formCards.append(waterBodyCard)
        formCards.append(weatherCard)
        formCards.append(airTempCard)
        formCards.append(surfaceTempCard)
        formCards.append(bottomTempCard)
        formCards.append(visibilityCard)
        formCards.append(visibilityDistanceCard)
        formCards.append(waveCard)
        formCards.append(currentCard)
        formCards.append(surgeCard)
        formCards.append(suitCard)
        formCards.append(weightCard)
        formCards.append(tankTypeCard)
        formCards.append(tankUnitCard)
        formCards.append(gasCard)
        formCards.append(oxygenCard)
        formCards.append(nitrogenCard)
        formCards.append(heliumCard)
        formCards.append(startPressureCard)
        formCards.append(endPressureCard)
        formCards.append(diveBuddyCard)
        formCards.append(diveCenterCard)
        formCards.append(noteCard)
    }
}
