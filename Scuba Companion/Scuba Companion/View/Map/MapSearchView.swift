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
    let notificationUtility: NotificationUtility
    weak var delegate: LocationFromSearchDelegate?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MapSearchCell.self, forCellReuseIdentifier: "subCell")
        
        return tableView
    }()
    
    init(notificationUtility: NotificationUtility){
        self.notificationUtility = notificationUtility
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .popover
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.backgroundColor = .systemBackground
        
        searchController.delegate = self
        searchController.searchResultsUpdater = self
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
//        searchCompleter.pointOfInterestFilter = MKPointOfInterestFilter(including: [MKPointOfInterestCategory.beach])
//        searchCompleter.pointOfInterestFilter = MKPointOfInterestFilter.init(including: [.beach])
        searchCompleter.pointOfInterestFilter = MKPointOfInterestFilter(including: [.beach])
        searchCompleter.resultTypes = .pointOfInterest
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
                self.navigationController?.dismiss(animated: true, completion: {
                    self.delegate?.goToSearchedLocation(center: center)
                })
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

    
    

