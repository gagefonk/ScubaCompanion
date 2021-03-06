//
//  MapSearchViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/11/21.
//

import Foundation
import MapKit


class MapSearchViewModel {
    
    var searchData: [MKLocalSearchCompletion] = []
    
    //search for location from search completer
    func performSearch(searchTerm: MKLocalSearchCompletion, completion: @escaping (_ foundItem: MKMapItem)->Void) {
        let searchRequest = MKLocalSearch.Request(completion: searchTerm)
        let search = MKLocalSearch(request: searchRequest)
        search.start { res, err in
            guard let res = res else {
                print(err?.localizedDescription)
                return
            }
            if let item = res.mapItems.first{
                completion(item)
            }
        }
        
    }
    
    func clearFilteredData() {
        searchData.removeAll()
    }
    
}
