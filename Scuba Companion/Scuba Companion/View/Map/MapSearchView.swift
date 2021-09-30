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
        
    }
    
    
}

extension MapSearchView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.searchTextField.text else { return }
        mapSearchVM.performSearch(searchTerm: searchText) {
            self.tableView.reloadData()
        }
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        mapSearchVM.clearFilteredData()
        tableView.reloadData()
    }
    
}

extension MapSearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapSearchVM.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath)
        
        let name = mapSearchVM.filteredData[indexPath.row].name ?? ""
        let detailed = mapSearchVM.filteredData[indexPath.row].placemark.title ?? ""
        cell.textLabel?.text = name
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.text = detailed
        cell.detailTextLabel?.textColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let center = mapSearchVM.filteredData[indexPath.row].placemark.coordinate
        searchController.dismiss(animated: false) {
            self.dismiss(animated: true) {
                self.delegate?.goToSearchedLocation(center: center)
            }
        }
        
    }
    
    
}

    
    

