//
//  DiveLogViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/9/21.
//

import Foundation

protocol DiveLogViewModelDelegate: AnyObject {
    func reloadTableData()
}

class DiveLogViewModel {
    var dives: [Dive] = []
    weak var delegate: DiveLogViewModelDelegate?
    
    init() {
        dives = DummyData().dives
    }
    
    func addDive(dive: Dive) {
        dives.append(dive)
        delegate?.reloadTableData()
    }
    
    func saveDive(dive: Dive, index: Int) {
        dives.remove(at: index)
        dives.insert(dive, at: index)
        delegate?.reloadTableData()
    }
    
    func getFormattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter.string(from: date)
    }
    
}
