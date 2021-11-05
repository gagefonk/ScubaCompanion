//
//  APIModels.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/4/21.
//

import Foundation

//get list of stations from URL

struct Locations: Codable {
    let locations: [Stations]
}

struct Stations: Codable {
    let stnid: String?
    let name: String?
    let state: String?
    let lat: String?
    let lng: String?
}
