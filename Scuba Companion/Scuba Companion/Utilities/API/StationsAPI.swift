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
    
    func getListOfStations(completion: @escaping ([Stations]?)->Void) {
        let url = URL(string: baseStationsURL)
        var request = URLRequest(url: url!)
        request.timeoutInterval = 10.0
        
        URLSession.shared.dataTask(with: request) { data, res, err in
            if err != nil {
                completion(nil)
                return
            }
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(Locations.self, from: data)
                completion(json.locations)
            } catch let error {
                completion(nil)
            }
        }.resume()
    }
}
