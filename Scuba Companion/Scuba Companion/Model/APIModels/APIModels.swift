//
//  APIModels.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/4/21.
//

import Foundation
import CoreLocation

enum APIError: LocalizedError {
    case url, data, json
    
    var errorDescription: String? {
        switch self {
        case .url:
            return NSLocalizedString("Failed to form URL", comment: "")
        case .data:
            return NSLocalizedString("Failed to retrieve data", comment: "")
        case .json:
            return NSLocalizedString("Failed to decode data", comment: "")
        }
    }
}

struct Stations: Codable {
    let stations: Station
}

struct Station: Codable {
    let station: [BuoyStation]
}

struct BuoyStation: Codable {
    let id: String?
    let lat: String?
    let lon: String?
}

struct WeatherData: Codable {
    
}
