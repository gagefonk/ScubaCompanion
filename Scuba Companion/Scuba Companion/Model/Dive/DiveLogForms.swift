//
//  DiveLogForms.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/10/21.
//

import Foundation

enum DiveLogType {
    case input, date, segment
}

struct DiveLogForms {
    var formCards: [DiveLogFormCard] = []

    init() {
        let titleCard = DiveLogFormCard(diveLogType: .input, charType: .all, title: "Dive Title", subtitle: "What is the title?", units: "", placeholder: "Add title", id: "title")
        let diveSiteCard = DiveLogFormCard(diveLogType: .input, charType: .all, title: "Dive Site", subtitle: "Where did you dive?", units: "", placeholder: "Add site", id: "site")
        let dateCard = DiveLogFormCard(diveLogType: .date, title: "Date", subtitle: "When was the dive?", id: "date")
        let diveTypeCard = DiveLogFormCard(diveLogType: .segment, title: "Dive Type", subtitle: "How did you get in the water?", segmentType: .diveType, id: "diveType")
        let maxDepthCard = DiveLogFormCard(diveLogType: .input, charType: .floatType, title: "Max Depth", subtitle: "How deep did you go?", units: "m", placeholder: "0.000", id: "maxDepth")
        let bottomTimeCard = DiveLogFormCard(diveLogType: .input, charType: .intType, title: "Bottom Time", subtitle: "How long were you down for?", units: "min", placeholder: "0", id: "bottomTime")
        let waterTypeCard = DiveLogFormCard(diveLogType: .segment, title: "Water Type", subtitle: "Fresh or salt water?", segmentType: .waterType, id: "waterType")
        let waterBodyCard = DiveLogFormCard(diveLogType: .segment, title: "Body of Water", subtitle: "What body of water did you dive in?", segmentType: .waterBody, id: "waterBody")
        let weatherCard = DiveLogFormCard(diveLogType: .segment, title: "Dive Weather", subtitle: "What was the weather like?", segmentType: .diveWeather, id: "weather")
        let airTempCard = DiveLogFormCard(diveLogType: .input, charType: .floatType, title: "Air Temperature", subtitle: "What was the air temperature?", units: "F", placeholder: "0.000", id: "airTemp")
        let surfaceTempCard = DiveLogFormCard(diveLogType: .input, charType: .floatType, title: "Surface Temperature", subtitle: "What was the surface temperature?", units: "F", placeholder: "0.000", id: "surfaceTemp")
        let bottomTempCard = DiveLogFormCard(diveLogType: .input, charType: .floatType, title: "Bottom Temperature", subtitle: "What was the bottom temperature?", units: "F", placeholder: "0.000", id: "bottomTemp")
        let visibilityCard = DiveLogFormCard(diveLogType: .segment, title: "Visibility", subtitle: "What was the visibility like?", segmentType: .diveVisibility, id: "visibility")
        let visibilityDistanceCard = DiveLogFormCard(diveLogType: .input, charType: .intType, title: "Visibility", subtitle: "How far could you see?", units: "m", placeholder: "0.000", id: "visibilityDistance")
        let waveCard = DiveLogFormCard(diveLogType: .segment, title: "Waves", subtitle: "How were the waves?", segmentType: .waves, id: "wave")
        let currentCard = DiveLogFormCard(diveLogType: .segment, title: "Current", subtitle: "How was the current?", segmentType: .current, id: "current")
        let surgeCard = DiveLogFormCard(diveLogType: .segment, title: "Surge", subtitle: "How was the surge?", segmentType: .surge, id: "surge")
        let suitCard = DiveLogFormCard(diveLogType: .segment, title: "Suit Type", subtitle: "What suit did you wear?", segmentType: .suitType, id: "suitType")
        let weightCard = DiveLogFormCard(diveLogType: .input, charType: .floatType, title: "Weight", subtitle: "How much weight did you have?", units: "lbs", placeholder: "0", id: "weight")
        let tankTypeCard = DiveLogFormCard(diveLogType: .segment, title: "Tank", subtitle: "What tank did you dive with?", segmentType: .tankType, id: "tankType")
        let tankUnitCard = DiveLogFormCard(diveLogType: .input, charType: .floatType, title: "Tank Units", subtitle: "What was the cylinder size?", units: "L", placeholder: "0.000", id: "tankUnits")
        let gasCard = DiveLogFormCard(diveLogType: .segment, title: "Gas Mixture", subtitle: "What kind of gas did you use?", segmentType: .gasMixture, id: "gas")
        let oxygenCard = DiveLogFormCard(diveLogType: .input, charType: .intType, title: "Oxygen", subtitle: "", units: "%", placeholder: "0", id: "oxygen")
        let nitrogenCard = DiveLogFormCard(diveLogType: .input, charType: .intType, title: "Nitrogen", subtitle: "", units: "%", placeholder: "0", id: "nitrogen")
        let heliumCard = DiveLogFormCard(diveLogType: .input, charType: .intType, title: "Helium", subtitle: "", units: "%", placeholder: "0", id: "helium")
        let startPressureCard = DiveLogFormCard(diveLogType: .input, charType: .floatType, title: "Start Pressure", subtitle: "What was the starting pressure?", units: "PSI", placeholder: "0.000", id: "startPressure")
        let endPressureCard = DiveLogFormCard(diveLogType: .input, charType: .floatType, title: "End Pressure", subtitle: "What was the ending pressure?", units: "PSI", placeholder: "0.000", id: "endPressure")
        let diveBuddyCard = DiveLogFormCard(diveLogType: .input, charType: .all, title: "Divy Buddy", subtitle: "Who did you dive with?", units: "", placeholder: "Add dive buddy", id: "diveBuddy")
        let diveCenterCard = DiveLogFormCard(diveLogType: .input, charType: .all, title: "Dive Center", subtitle: "Did you go with a dive center?", units: "", placeholder: "Add dive center", id: "diveCenter")
        let noteCard = DiveLogFormCard(diveLogType: .input, charType: .all, title: "Notes", subtitle: "Any notes you'd like to add?", units: "", placeholder: "Add note", id: "note")

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
