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
    weak var delegate: LocationFromSearchDelegate?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MapSearchCell.self, forCellReuseIdentifier: "subCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.backgroundColor = UIColor(named: "darkBackground")
        
        searchController.searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchCompleter.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.frame
    }
    
    private func clearSearch() {
        
        searchController.searchBar.searchTextField.text = ""
        mapSearchVM.clearFilteredData()
        tableView.reloadData()
    }
    
    
}

extension MapSearchView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.searchTextField.text else { return }
        searchCompleter.pointOfInterestFilter = MKPointOfInterestFilter(including: [MKPointOfInterestCategory.beach])
        searchCompleter.queryFragment = searchText
    }
    
}

extension MapSearchView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
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
            //clear search
            self.clearSearch()
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

    
    

