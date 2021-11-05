//
//  MapView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/10/21.
//

import UIKit
import MapKit
import Firebase

class MapView: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let mapSearchView = MapSearchView()
    let mapVM = MapViewModel()
    let surfAPI = SurfAPI()
    
    
    let mapView: MKMapView = {
        
        let map = MKMapView()
        map.pointOfInterestFilter = .excludingAll
        map.mapType = .mutedStandard
        map.showsBuildings = false
        
        return map
    }()
    
    let addButton: UIButton = {
        
        let button = UIButton()
        button.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    let doneButton: UIButton = {
        
        let button = UIButton()
        button.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    let cancelButton: UIButton = {
        
        let button = UIButton()
        button.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    let pinImage: UIImageView = {
        
        let imageView = UIImageView()
        
        return imageView
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        locationManager.delegate = self
        mapSearchView.delegate = self
        requestLocationServicesAuthorization()
        
        view.addSubview(mapView)
        view.addSubview(addButton)
        
        //add search functionality
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location"), style: .done, target: self, action: #selector(goToCurrentLocation))
        
        //add pins
        updatePins()
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        setupLayout()
        
    }
    
    func setupLayout() {
        
        //add symbol config
        let menuButtonConfig = UIImage.SymbolConfiguration(pointSize: view.frame.height * 0.04, weight: .bold, scale: .large)
        
        //map view
        mapView.frame = view.bounds
        
        //add button
        addButton.setImage(UIImage(systemName: "plus.circle", withConfiguration: menuButtonConfig), for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        addButton.bottomAnchor.constraint(equalTo: tabBarController!.tabBar.topAnchor, constant: -40).isActive = true
        
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
    
    private func updatePins() {
        
        var annotations: [MKPointAnnotation] = []
        
        mapVM.data.forEach { pin in
            if let coord = pin.pinLocation {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coord
                annotation.title = pin.title
                annotations.append(annotation)
            }
        }
        
        mapView.addAnnotations(annotations)
    }
    
    private func removeAllPins() {
        
        mapView.removeAnnotations(mapView.annotations)
    }
    
    private func showAddPinView() {
        
        //add symbol config
        let menuButtonConfig = UIImage.SymbolConfiguration(pointSize: view.frame.height * 0.04, weight: .bold, scale: .large)
        
        //add pin image to center
        mapView.addSubview(pinImage)
        let pinImageConfig = UIImage.SymbolConfiguration(pointSize: view.frame.height * 0.04, weight: .regular, scale: .default)
        pinImage.image = UIImage(systemName: "mappin", withConfiguration: pinImageConfig)
        pinImage.translatesAutoresizingMaskIntoConstraints = false
        pinImage.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pinImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //hide add button
        addButton.isHidden = true
        
        //add done button
        mapView.addSubview(doneButton)
        doneButton.setImage(UIImage(systemName: "checkmark.circle", withConfiguration: menuButtonConfig), for: .normal)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: tabBarController!.tabBar.topAnchor, constant: -40).isActive = true
        
        //add cancel button
        mapView.addSubview(cancelButton)
        cancelButton.setImage(UIImage(systemName: "x.circle", withConfiguration: menuButtonConfig), for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: tabBarController!.tabBar.topAnchor, constant: -40).isActive = true
        
    }
    
    private func removeAddPinView() {
        
        //remove pin image
        pinImage.removeFromSuperview()
        doneButton.removeFromSuperview()
        cancelButton.removeFromSuperview()
        
        //show add button
        addButton.isHidden = false
        
        //update pins
        updatePins()
    }
    
    @objc private func addButtonClicked() {
        
        removeAllPins()
        
        showAddPinView()
        
    }
    
    @objc private func doneButtonClicked() {
        
        //add annotation
        mapVM.addPin(center: mapView.centerCoordinate)
        removeAddPinView()
    }
    
    @objc private func cancelButtonClicked() {
        
        removeAddPinView()
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
    
    @objc func apiCall() {
        
//        surfAPI.getData()
    }

}

extension MapView: LocationFromSearchDelegate {
    
    func goToSearchedLocation(center: CLLocationCoordinate2D) {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        let newRegion = mapView.regionThatFits(region)
        mapView.setRegion(newRegion, animated: true)
    }
    
    
}
