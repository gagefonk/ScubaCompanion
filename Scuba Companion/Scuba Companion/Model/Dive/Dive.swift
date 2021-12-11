//
//  Dive.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/8/21.
//

import Foundation

enum DiveLogInputType: CaseIterable {
    case diveType, waterType, waterBody, diveWeather, diveVisibility, waves, current, surge, suitType, tankType, gasMixture
}

enum DiveSliderType {
    case maxDepth, time, temp, vis, weight, tank, gas, pressure
}

enum DivePickerType {
    case suit, gas
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
