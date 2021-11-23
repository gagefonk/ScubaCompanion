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
    let mapSearchView: MapSearchView
    let mapVM = MapViewModel()
    let stationAPI = StationsAPI()
    let notificationUtility = NotificationUtility()
    
    let mapView: MKMapView = {
        
        let map = MKMapView()
        map.pointOfInterestFilter = .excludingAll
        map.mapType = .mutedStandard
        map.showsBuildings = false
        
        return map
    }()
    
    init() {
        self.mapSearchView = MapSearchView(notificationUtility: notificationUtility)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 0)
        self.tabBarController?.tabBar.barTintColor = .darkBackground
        
        locationManager.delegate = self
        mapSearchView.delegate = self
        requestLocationServicesAuthorization()
    
        view.addSubview(mapView)
        
        //add search functionality
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        navigationItem.rightBarButtonItem?.tintColor = .systemPrimary
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location"), style: .done, target: self, action: #selector(goToCurrentLocation))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(displaySurfData))
        navigationItem.leftBarButtonItem?.tintColor = .systemPrimary
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    private func requestLocationServicesAuthorization() {
        
        if !isLocationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
    }
    
    private func isLocationServicesEnabled() -> Bool {
        return locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways
    }
    
    @objc private func displaySurfData() {
        let surfView = SurfView()
        navigationController?.pushViewController(surfView, animated: true)
    }
    
//    @objc private func goToCurrentLocation() {
//        if isLocationServicesEnabled() {
//            guard let region = mapVM.getUserLocation(locationManager: locationManager) else { return }
//            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//            let newRegion = MKCoordinateRegion(center: region.center, span: span)
//            let fitRegion = mapView.regionThatFits(newRegion)
//            mapView.setRegion(fitRegion, animated: true)
//            mapView.showsUserLocation = true
//        } else {
//            requestLocationServicesAuthorization()
//        }
//    }
    
    @objc func didTapSearch() {
        present(UINavigationController(rootViewController: mapSearchView), animated: true, completion: nil)
    }

}

extension MapView: LocationFromSearchDelegate {

    func goToSearchedLocation(center: CLLocationCoordinate2D) {
        
        let chosenLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        let newRegion = mapView.regionThatFits(region)
        mapView.setRegion(newRegion, animated: true)

        mapVM.getClosestStation(chosenLocation: chosenLocation) { err in
            guard let err = err else { return }
            DispatchQueue.main.async {
                let alert = self.notificationUtility.getAlert(title: "Location Error", error: err)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
}
