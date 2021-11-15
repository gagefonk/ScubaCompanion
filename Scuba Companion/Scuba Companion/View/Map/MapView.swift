//
//  MapView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/10/21.
//

import UIKit
import MapKit

class MapView: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let mapSearchView = MapSearchView()
    let mapVM = MapViewModel()
    let surfAPI = SurfAPI()
    let stationAPI = StationsAPI()
    
    
    let mapView: MKMapView = {
        
        let map = MKMapView()
        map.pointOfInterestFilter = .excludingAll
        map.mapType = .mutedStandard
        map.showsBuildings = false
        
        return map
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        locationManager.delegate = self
        mapSearchView.delegate = self
        requestLocationServicesAuthorization()
        
        view.addSubview(mapView)
        
        //add search functionality
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location"), style: .done, target: self, action: #selector(goToCurrentLocation))
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        setupLayout()
        
    }
    
    func setupLayout() {
        
        //map view
        mapView.frame = view.frame
        
    }
    
    private func requestLocationServicesAuthorization() {
        
        if !isLocationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
    }
    
    private func isLocationServicesEnabled() -> Bool {
        
        if locationManager.authorizationStatus != .authorizedWhenInUse || locationManager.authorizationStatus != .authorizedAlways {
            return false
        } else {
            return true
        }
    }
    
    @objc private func goToCurrentLocation() {
        if isLocationServicesEnabled() {
            guard let region = mapVM.getUserLocation(locationManager: locationManager) else { return }
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let newRegion = MKCoordinateRegion(center: region.center, span: span)
            let fitRegion = mapView.regionThatFits(newRegion)
            mapView.setRegion(fitRegion, animated: true)
            mapView.showsUserLocation = true
        } else {
            requestLocationServicesAuthorization()
        }
    }
    
    @objc func didTapSearch() {
        
        present(UINavigationController(rootViewController: mapSearchView), animated: true, completion: nil)
        
    }

}

extension MapView: LocationFromSearchDelegate {

    func goToSearchedLocation(center: CLLocationCoordinate2D) {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        let newRegion = mapView.regionThatFits(region)
        mapView.setRegion(newRegion, animated: true)
        
        mapVM.getClosestStation(chosenLocation: center)
    }
    
    
}
