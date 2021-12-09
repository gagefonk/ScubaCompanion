//
//  WeatherAPI.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 12/5/21.
//

import Foundation

class WeatherAPI {
    
    func getWeather(lat: String, long: String, completion: (Result<WeatherData, APIError>) -> ()) {
        testFunct { strings in
            
            strings.forEach { s in
                print(s)
            }
        }
        
    }
    
    func testFunct(completion: ([String]) -> Void) {
        completion(["1", "2", "3"])
    }
    
    
}
