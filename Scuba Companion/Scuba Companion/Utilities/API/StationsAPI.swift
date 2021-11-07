//
//  Stations.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/4/21.
//

import Foundation
import CoreLocation


struct StationsAPI {
    
    private let baseStationsURL: String = {
        var plistDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "api", ofType: "plist") {
            plistDictionary = NSDictionary(contentsOfFile: path)
        }
        return plistDictionary?["stationsBaseURL"] as! String
    }()
    
    func getListOfStations(completion: @escaping ([StationLocation])->Void) {
        let url = URL(string: baseStationsURL)
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { data, res, err in
            if err != nil {
                print(err?.localizedDescription as Any)
                return
            }
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(Locations.self, from: data)
                let stationLocations = formatLocations(locations: json)
                completion(stationLocations)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private func formatLocations(locations: Locations) -> [StationLocation]{
        
        var stationLocations: [StationLocation] = []
        locations.locations.forEach { station in
            guard let lonString = station.lng, let latString = station.lat, let name = station.name, let id = station.stnid else { return }
            guard let lon = Double(lonString), let lat = Double(latString) else { return }
            let loc = CLLocation(latitude: lat, longitude: lon)
            let stationLocation = StationLocation(name: name, id: id, location: loc)
            stationLocations.append(stationLocation)
        }
        return stationLocations
    }
}
