//
//  SurfAPI.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/14/21.
//

import Foundation


struct SurfAPI {
    
    let token: String = {
        var plistDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "api", ofType: "plist") {
            plistDictionary = NSDictionary(contentsOfFile: path)
        }
        return plistDictionary?["token"] as! String
    }()
    
    let baseURL: String = {
        var plistDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "api", ofType: "plist") {
            plistDictionary = NSDictionary(contentsOfFile: path)
        }
        return plistDictionary?["baseApiURL"] as! String
    }()
}
