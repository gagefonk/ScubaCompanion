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
    }
    
    func getUserLocation(locationManager: CLLocationManager) -> MKCoordinateRegion? {
        guard let location = locationManager.location else {return nil}
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), latitudinalMeters: 300, longitudinalMeters: 300)
        return region
    }
    
    func getClosestStation(chosenLocation: CLLocation, completion: @escaping (Error?)->Void) {
        getListOfStations { [weak self] err in
            guard let self = self, err == nil else {
                completion(err)
                return
            }
            //get closest station
            var closestLocation = self.stationList[0]
            for station in self.stationList {
                let distanceFromClosest = chosenLocation.distance(from: closestLocation.location)
                let distanceFromNext = chosenLocation.distance(from: station.location)
                closestLocation = distanceFromNext < distanceFromClosest ? station : closestLocation
            }
            print("The closest station to chosen location is: Name: \(closestLocation.name)\nID: \(closestLocation.id)\nLat: \(closestLocation.location.coordinate.latitude)\nLon:\(closestLocation.location.coordinate.longitude)")
            completion(nil)
        }
    }
    
    private func getListOfStations(completion: @escaping (APIError?) -> Void) {
        if stationList.isEmpty {
            stationsAPI.getListOfStations { [weak self] result in
                guard let self = self else {
                    completion(.data)
                    return
                }
                switch result {
                case .success(let stations):
                    self.stationList = self.formatLocations(stations: stations)
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        }
    }
    
    private func formatLocations(stations: [Stations]) -> [StationLocation]{
        
        var stationLocations: [StationLocation] = []
        for station in stations {
            guard let lonString = station.lng, let latString = station.lat, let name = station.name, let id = station.stnid else { break }
            guard let lon = Double(lonString), let lat = Double(latString) else { break }
            let loc = CLLocation(latitude: lat, longitude: lon)
            let stationLocation = StationLocation(name: name, id: id, location: loc)
            stationLocations.append(stationLocation)
        }
        return stationLocations
    }
}
