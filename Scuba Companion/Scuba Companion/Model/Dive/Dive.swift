//
//  Dive.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/8/21.
//

import Foundation

enum DiveType {
    case boat, shore, other
}

enum WaterType {
    case fresh, salt
}

enum WaterBody {
    case ocean, lake, quarry, river, other
}

enum DiveWeather {
    case sun, cloudy, rainy, windy, foggy, partlyCloudy
}

enum DiveVisibility {
    case high, average, low
}

enum Waves {
    case none, small, medium, large
}

enum Current {
    case none, light, medium, strong
}
enum Surge {
    case light, medium, strong
}

enum SuitType {
    case none, threemm, fivemm, sevenmm, short, semi, dry
}

enum TankType {
    case steel, aluminum, other
}

enum GasMixture {
    case air, ean32, ean36, ean40, enriched, trimex, rebreather
}

struct Dive {
    
    let title: String
    let site: String
//    let date: Date
    let diveType: DiveType
    let maxDepth: Int
    let diveLength: Int
    let waterType: WaterType
    let waterBody: WaterBody
    let diveWeather: DiveWeather
    let airTemp: Int
    let surfaceTemp: Int
    let bottomTemp: Int
    let visibility: DiveVisibility
    let visibilityInMeters: Int
    let waves: Waves
    let current: Current
    let surge: Surge
    let suitType: SuitType
    let weight: Int
    let tankType: TankType
    let tankSize: Int
    let gasMixture: GasMixture
    let oxygen: Int
    let nitrogen: Int
    let helium: Int
    let startPressure: Int
    let endPressure: Int
    lazy var amountUsed: Int = {
        return startPressure - endPressure
    }()
    let note: String
    let diveBuddy: [String]
    let diveCenter: String
}
