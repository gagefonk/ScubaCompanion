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
    func goToSearchedLocation(chosenLocation: CLLocation) {
        mapVM.getClosestStation(chosenLocation: chosenLocation) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let buoyStation):
                    guard let location = self.mapVM.formatLocations(buoyStation: buoyStation) else { return }
                    let center = location.coordinate
                    let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                    let region = MKCoordinateRegion(center: center, span: span)
                    let fitRegion = self.mapView.regionThatFits(region)
                    self.mapView.setRegion(fitRegion, animated: true)
                case .failure(let error):
                    let alert = self.notificationUtility.getAlert(title: "Location Error", error: error)
                    self.present(alert, animated: true, completion: nil)
            }
            }
        }
    }
    
    
}
