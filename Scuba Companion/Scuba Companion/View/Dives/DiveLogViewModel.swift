//
//  DiveLogViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/9/21.
//

import Foundation


class DiveLogViewModel {
    var dives: [Dive] = []
    
    init() {
        addData()
    }
    
    func addData() {
        for _ in 0...19 {
            let dive = Dive(title: "La Jolla", site: "La Jolla", diveType: .shore, maxDepth: 30, diveLength: 30, waterType: .salt, waterBody: .ocean, diveWeather: .sun, airTemp: 70, surfaceTemp: 70, bottomTemp: 70, visibility: .high, visibilityInMeters: 30, waves: .none, current: .none, surge: .light, suitType: .sevenmm, weight: 25, tankType: .aluminum, tankSize: 80, gasMixture: .air, oxygen: 95, nitrogen: 0, helium: 0, startPressure: 3000, endPressure: 300, note: "", diveBuddy: ["Rob"], diveCenter: "None")
            dives.append(dive)
        }
    }
}
