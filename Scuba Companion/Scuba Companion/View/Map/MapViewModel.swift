//
//  MapViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/10/21.
//

import UIKit
import MapKit

class MapViewModel {
    
    let stationsAPI = StationsAPI()
    var stationList: [StationLocation] = []
    
    init() {
        stationsAPI.getListOfStations { stations in
            self.stationList = stations
        }
    }
    
    func getUserLocation(locationManager: CLLocationManager) -> MKCoordinateRegion? {
        guard let location = locationManager.location else {return nil}
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), latitudinalMeters: 300, longitudinalMeters: 300)
        return region
    }
    
    func getClosestStation(chosenLocation: CLLocationCoordinate2D) {

        var closestLocation = stationList[0].location
        stationList.forEach { station in
            let location = CLLocation(latitude: chosenLocation.latitude, longitude: chosenLocation.longitude)
            let distanceFromStations = location.distance(from: station.location)
            let distanceFromCurrent = location.distance(from: closestLocation)
            if distanceFromStations < distanceFromCurrent {
                closestLocation = station.location
            }
        }
        print("The closest station to chosen location is: \(closestLocation.coordinate.latitude), \(closestLocation.coordinate.longitude)")
    }
}
