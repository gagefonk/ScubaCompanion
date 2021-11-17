//
//  Dive.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/8/21.
//

import Foundation

enum DiveLogInputType: CaseIterable {
    case diveType
    case waterType
    case waterBody
    case diveWeather
    case diveVisibility
    case waves
    case current
    case surge
    case suitType
    case tankType
    case gasMixture
}

enum DiveType: String, CaseIterable {
    case shore = "Shore", boat = "Boat", other = "Other"
}

enum WaterType: String, CaseIterable {
    case salt = "Salt", fresh = "Fresh"
}

enum WaterBody: String, CaseIterable {
    case ocean = "Ocean", lake = "Lake", quarry = "Quarry", river = "River", other = "Other"
}

enum DiveWeather: String, CaseIterable {
    case sun = "Sun", cloudy = "Cloudy", rainy = "Rainy", windy = "Windy", foggy = "Foggy"
}

enum DiveVisibility: String, CaseIterable {
    case high = "High", average = "Average", low = "Low"
}

enum Waves: String, CaseIterable {
    case none = "None", small = "Small", medium = "Medium", large = "Large"
}

enum Current: String, CaseIterable {
    case none = "None", light = "Light", medium = "Medium", strong = "Strong"
}
enum Surge: String, CaseIterable {
    case light = "Light", medium = "Medium", strong = "Strong"
}

enum SuitType: String, CaseIterable {
    case none = "None", threemm = "3mm", fivemm = "5mm", sevenmm = "7mm", short = "Short", semi = "Semi", dry = "Dry"
}

enum TankType: String, CaseIterable {
    case aluminum = "Aluminum", steel = "Steel", other = "Other"
}

enum GasMixture: String, CaseIterable {
    case air = "Air", ean32 = "32", ean36 = "36", ean40 = "40", enriched = "Enriched", trimex = "Trimex", rebreather = "Rebreather"
}

struct Dive {
    
    let title: String
    let site: String
    let date: Date
    let diveType: DiveType
    let maxDepth: Float
    let diveLength: Float
    let waterType: WaterType
    let waterBody: WaterBody
    let diveWeather: DiveWeather
    let airTemp: Float
    let surfaceTemp: Float
    let bottomTemp: Float
    let visibility: DiveVisibility
    let visibilityInMeters: Float
    let waves: Waves
    let current: Current
    let surge: Surge
    let suitType: SuitType
    let weight: Float
    let tankType: TankType
    let tankSize: Float
    let gasMixture: GasMixture
    let oxygen: Float
    let nitrogen: Float
    let helium: Float
    let startPressure: Float
    let endPressure: Float
    let amountUsed: Float
    let note: String
    let diveBuddy: String
    let diveCenter: String
}
