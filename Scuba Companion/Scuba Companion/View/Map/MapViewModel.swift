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
    var stationList: [BuoyStation] = []
    
    init() {
    }
    
    func getUserLocation(locationManager: CLLocationManager) -> MKCoordinateRegion? {
        guard let location = locationManager.location else {return nil}
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), latitudinalMeters: 300, longitudinalMeters: 300)
        return region
    }
    
    func getClosestStation(chosenLocation: CLLocation, completion: @escaping (Result<BuoyStation, APIError>)->Void) {
        getListOfStations { [weak self] err in
            guard let self = self, err == nil else {
                completion(.failure(err!))
                return
            }
            //get closest station
            var closestLocation = self.stationList[0]
            for station in self.stationList {
                guard let chosenLocationFormatted = self.formatLocations(buoyStation: closestLocation) else { return }
                guard let nextLocationFormatted = self.formatLocations(buoyStation: station) else { return }
                let distanceFromClosest = chosenLocation.distance(from: chosenLocationFormatted)
                let distanceFromNext = chosenLocation.distance(from: nextLocationFormatted)
                closestLocation = distanceFromNext < distanceFromClosest ? station : closestLocation
            }
            print("The closest station to chosen location is: ID: \(closestLocation.id)\nLat: \(closestLocation.lat)\nLon:\(closestLocation.lon)")
            completion(.success(closestLocation))
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
                case .success(let buoyStations):
                    self.stationList = buoyStations
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        } else {
            completion(nil)
        }
    }
    
    func formatLocations(buoyStation: BuoyStation) -> CLLocation?{
        guard let latString = buoyStation.lat, let lonString = buoyStation.lon else { return nil }
        guard let lat = Double(latString), let lon = Double(lonString) else { return nil }
        return CLLocation(latitude: lat, longitude: lon)
    }
}
