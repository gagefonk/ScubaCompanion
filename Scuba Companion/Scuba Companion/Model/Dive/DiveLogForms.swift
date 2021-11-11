//
//  DiveLogForms.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/10/21.
//

import Foundation

struct DiveLogForms {
    var forms: [DiveLogCard] = []
    
    init() {
        let titleCard = DiveLogCard(group: .input, textType: .all, title: "Dive Title", subtitle: "What is the title?", placeholder: "Add title", units: "")
        let diveSiteCard = DiveLogCard(group: .input, textType: .all, title: "Dive Site", subtitle: "Where did you dive?", placeholder: "Add Site", units: "")
        let dateCard = DiveLogCard(group: .date, title: "Date", subtitle: "When was the dive?")
        let diveTypeCard = DiveLogCard(group: .typeInput, inputType: .diveType, title: "Type of Dive", subtitle: "How did you get in the water?")
        let maxDepthCard = DiveLogCard(group: .input, textType: .floatType, title: "Max Depth", subtitle: "How deep did you go?", placeholder: "0.000", units: "m")
        let bottomTimeCard = DiveLogCard(group: .input, textType: .intType, title: "Bottom Time", subtitle: "How long were you down for?", placeholder: "0", units: "min")
        let waterTypeCard = DiveLogCard(group: .typeInput, inputType: .waterType, title: "Water Type", subtitle: "Fresh or salt water?")
        let waterBodyCard = DiveLogCard(group: .typeInput, inputType: .waterBody, title: "Body of Water", subtitle: "What body of water did you dive in?")
        let weatherCard = DiveLogCard(group: .typeInput, inputType: .diveWeather, title: "Dive Weather", subtitle: "What was the weather like?")
        let airTempCard = DiveLogCard(group: .input, textType: .intType, title: "Air Temperature", subtitle: "What was the air temperature?", placeholder: "0.000", units: "F")
        let surfaceTempCard = DiveLogCard(group: .input, textType: .floatType, title: "Surface Temperature", subtitle: "What was the surface temperature?", placeholder: "0.000", units: "F")
        let bottomTempCard = DiveLogCard(group: .input,  textType: .floatType, title: "Bottom Temperature", subtitle: "What was the bottom temperature?", placeholder: "0.000", units: "F")
        let visibilityCard = DiveLogCard(group: .typeInput, inputType: .diveVisibility, title: "Visibility", subtitle: "What was the visibility like?")
        let visibilityDistanceCard = DiveLogCard(group: .input, textType: .floatType, title: "Visibility", subtitle: "How far could you see?", placeholder: "0.000", units: "m")
        let waveCard = DiveLogCard(group: .typeInput, inputType: .waves, title: "Waves", subtitle: "How were the waves?")
        let currentCard = DiveLogCard(group: .typeInput, inputType: .current, title: "Current", subtitle: "How was the current?")
        let surgeCard = DiveLogCard(group: .typeInput, inputType: .surge, title: "Surge", subtitle: "How was the surge?")
        let suitCard = DiveLogCard(group: .typeInput, inputType: .suitType, title: "Suit Type", subtitle: "What suit did you wear?")
        let weightCard = DiveLogCard(group: .input, textType: .intType, title: "Weight", subtitle: "How much weight did you have?", placeholder: "0", units: "lbs")
        let tankTypeCard = DiveLogCard(group: .typeInput, inputType: .tankType, title: "Tank", subtitle: "What tank did you dive with?")
        let tankUnitCard = DiveLogCard(group: .input, textType: .floatType, title: "Tank Units", subtitle: "What was the cylinder size?", placeholder: "0.000", units: "L")
        let gasCard = DiveLogCard(group: .typeInput, inputType: .gasMixture, title: "Gas Mixture", subtitle: "What kind of gas did you use?")
        let oxygenCard = DiveLogCard(group: .input, textType: .intType, title: "Oxygen", subtitle: "", placeholder: "0", units: "%")
        let nitrogenCard = DiveLogCard(group: .input, textType: .intType, title: "Nitrogen", subtitle: "", placeholder: "0", units: "%")
        let heliumCard = DiveLogCard(group: .input, textType: .intType, title: "Helium", subtitle: "", placeholder: "0", units: "%")
        let startPressureCard = DiveLogCard(group: .input, textType: .floatType, title: "Start Pressure", subtitle: "What was the starting pressure?", placeholder: "0.000", units: "PSI")
        let endPressureCard = DiveLogCard(group: .input, textType: .floatType, title: "End Pressure", subtitle: "What was the ending pressure?", placeholder: "0.000", units: "PSI")
        let diveBuddyCard = DiveLogCard(group: .input, textType: .all, title: "Dive Buddy", subtitle: "Who did you dive with?", placeholder: "Add dive buddy", units: "")
        let diveCenterCard = DiveLogCard(group: .input, textType: .all, title: "Notes", subtitle: "Did you go with a dive center?", placeholder: "Add dive center", units: "")
        let noteCard = DiveLogCard(group: .input, textType: .all, title: "Notes", subtitle: "Any notes you'd like to add?", placeholder: "Add note", units: "")
        
        
        forms.append(titleCard)
        forms.append(diveSiteCard)
        forms.append(dateCard)
        forms.append(diveTypeCard)
        forms.append(maxDepthCard)
        forms.append(bottomTimeCard)
        forms.append(waterTypeCard)
        forms.append(waterBodyCard)
        forms.append(weatherCard)
        forms.append(airTempCard)
        forms.append(surfaceTempCard)
        forms.append(bottomTempCard)
        forms.append(visibilityCard)
        forms.append(visibilityDistanceCard)
        forms.append(waveCard)
        forms.append(currentCard)
        forms.append(surgeCard)
        forms.append(suitCard)
        forms.append(weightCard)
        forms.append(tankTypeCard)
        forms.append(tankUnitCard)
        forms.append(gasCard)
        forms.append(oxygenCard)
        forms.append(nitrogenCard)
        forms.append(heliumCard)
        forms.append(startPressureCard)
        forms.append(endPressureCard)
        forms.append(diveBuddyCard)
        forms.append(diveCenterCard)
        forms.append(noteCard)
    }
}
