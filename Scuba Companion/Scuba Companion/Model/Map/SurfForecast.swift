//
//  SurfForecast.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/17/21.
//

import Foundation

enum SurfCardType {
    case date, progress, temp, tide, swell, wind, weather
}

struct SurfForecast {
    
    let date: Date
    let seaTemp: String
    let lowTide: String
    let highTide: String
    let swellHeight: String
    let swellPeriod: String
    let swellDirection: String
    let windSpeed: String
    let windDirection: String
    let weatherDesc: String
    
}
