//
//  Stations.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/4/21.
//

import Foundation


struct StationsAPI {
    
    let baseStationsURL: String = {
        var plistDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "api", ofType: "plist") {
            plistDictionary = NSDictionary(contentsOfFile: path)
        }
        return plistDictionary?["stationsBaseURL"] as! String
    }()
    
    func getListOfStations() {
        let url = URL(string: baseStationsURL)
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { data, res, err in
            if err != nil {
                print(err?.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(Locations.self, from: data)
                json.locations.forEach { station in
                    print(station.state)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
