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
        stationsAPI.getListOfStations { stations in
            var closestLocation = stations[0]
            let chosenLocation = CLLocation(latitude: chosenLocation.latitude, longitude: chosenLocation.longitude)
            stations.forEach { station in
                let distanceFromStations = chosenLocation.distance(from: station.location)
                let distanceFromCurrent = chosenLocation.distance(from: closestLocation.location)
                if distanceFromStations < distanceFromCurrent {
                    closestLocation = station
                }
            }
            print("The closest station to chosen location is: Name: \(closestLocation.name)\nID: \(closestLocation.id)\nLat: \(closestLocation.location.coordinate.latitude)\nLon:\(closestLocation.location.coordinate.longitude)")
        }
    }
}
