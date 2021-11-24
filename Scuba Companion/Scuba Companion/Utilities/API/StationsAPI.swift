//
//  Stations.swift
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


class StationsAPI {
    
    private let baseStationsURL: String = {
        var plistDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "api", ofType: "plist") {
            plistDictionary = NSDictionary(contentsOfFile: path)
        }
        return plistDictionary?["stationsBaseURL"] as! String
    }()
    
    func getListOfStations(completion: @escaping ((Result<[BuoyStation], APIError>) -> Void)){
        guard let url = URL(string: baseStationsURL) else {
            completion(.failure(.url))
            return
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        
        URLSession.shared.dataTask(with: request) { data, _, err in
            guard let data = data, err == nil else {
                completion(.failure(.data))
                print("failed")
                return
            }
            do {
                print("decoding")
                let json = try JSONDecoder().decode(Stations.self, from: data)
                completion(.success(json.stations.station))
            } catch {
                print("cant decode")
                completion(.failure(.json))
            }
        }.resume()
    }
    
}
