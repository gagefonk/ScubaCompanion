//
//  MapSearchViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/11/21.
//

import Foundation
import MapKit


class MapSearchViewModel {
    
    var filteredData: [MKMapItem] = []
    
    func performSearch(searchTerm: String, completion: @escaping ()->Void) {
        
        if searchTerm != "" {
            let searchRequest = MKLocalSearch.Request()
            let interestCategory = MKPointOfInterestCategory.beach
            searchRequest.pointOfInterestFilter = MKPointOfInterestFilter(including: [interestCategory])
            searchRequest.naturalLanguageQuery = searchTerm
            
            let search = MKLocalSearch(request: searchRequest)
            
            search.start { result, err in
                guard let result = result else {
                    print(err!)
                    return
                }
                //clear data for each search
                self.clearFilteredData()
                
                result.mapItems.forEach { item in
                    self.filteredData.append(item)
                }
                completion()
            }
        }
        else {
            completion()
        }
        
        
    }
    
    func clearFilteredData() {
        filteredData.removeAll()
    }
    
}
