//
//  MapViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/10/21.
//

import UIKit
import MapKit

class MapViewModel {
    
    var data: [DivePin] = []
    
    init() {
        let tempData = DivePin(pinLocation: CLLocationCoordinate2D(latitude: 34.010090, longitude: -118.496948), title: "Santa Monica")
        data.append(tempData)
    }
    
    func getUserLocation(locationManager: CLLocationManager) -> MKCoordinateRegion? {
        guard let location = locationManager.location else {return nil}
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), latitudinalMeters: 300, longitudinalMeters: 300)
        return region
    }
    
    func addPin(center: CLLocationCoordinate2D) {
        let newPin = DivePin(pinLocation: center, title: "Test Title")
        data.append(newPin)
        print(data)
    }
}
