//
//  APIModels.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/4/21.
//

import Foundation
import CoreLocation

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
