//
//  MapSearchView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/11/21.
//

import UIKit
import MapKit

protocol LocationFromSearchDelegate: AnyObject {
    func goToSearchedLocation(center: CLLocationCoordinate2D)
}

class MapSearchView: UIViewController, UISearchControllerDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    let mapSearchVM = MapSearchViewModel()
    let searchCompleter = MKLocalSearchCompleter()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MapSearchCell.self, forCellReuseIdentifier: "subCell")
        
        return tableView
    }()
    
    weak var delegate: LocationFromSearchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        title = "Search"
        
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 30, weight: .bold)
        ]
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.backgroundColor = UIColor(named: "darkBackground")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        searchCompleter.delegate = self
        
    }
    
    
}

extension MapSearchView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.searchTextField.text else { return }
        searchCompleter.pointOfInterestFilter = MKPointOfInterestFilter(including: [MKPointOfInterestCategory.beach])
        searchCompleter.queryFragment = searchText
        
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        mapSearchVM.clearFilteredData()
        tableView.reloadData()
    }
    
}

extension MapSearchView: UITableViewDelegate, UITableViewDataSource, MKLocalSearchCompleterDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapSearchVM.searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath)
        let name = mapSearchVM.searchData[indexPath.row].title
        let detailed = mapSearchVM.searchData[indexPath.row].subtitle
        cell.textLabel?.text = name
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.text = detailed
        cell.detailTextLabel?.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        mapSearchVM.performSearch(searchTerm: mapSearchVM.searchData[indexPath.row]) { foundItem in
            let center = foundItem.placemark.coordinate
            self.searchController.dismiss(animated: false) {
                self.dismiss(animated: true) {
                    self.delegate?.goToSearchedLocation(center: center)
                }
            }
        }
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        mapSearchVM.searchData = completer.results
        tableView.reloadData()
        
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
}

    
    

