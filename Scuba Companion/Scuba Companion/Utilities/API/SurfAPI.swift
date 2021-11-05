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
    

//    func getData() {
//        let header: [String : String] = [
//            "token" : token
//        ]
//        let url = URL(string: baseURL + "datacategories")
//        var request = URLRequest(url: url!)
//        request.allHTTPHeaderFields = header
//        request.httpMethod = "get"
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else {
//                print(error!)
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                let codeableData = try decoder.decode(DataCategories.self, from: data)
//                codeableData.results.forEach { result in
//                    print(result.name)
//                }
//            }
//            catch let parsingError {
//                print(parsingError)
//            }
//            
//        }.resume()
//    }
}
