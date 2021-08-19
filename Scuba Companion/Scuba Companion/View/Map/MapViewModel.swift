//
//  MapViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/10/21.
//

import UIKit
import MapKit

class MapViewModel {
    
    
    func getUserLocation(locationManager: CLLocationManager) -> MKCoordinateRegion? {
        guard let location = locationManager.location else {return nil}
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), latitudinalMeters: 300, longitudinalMeters: 300)
        return region
    }
}
