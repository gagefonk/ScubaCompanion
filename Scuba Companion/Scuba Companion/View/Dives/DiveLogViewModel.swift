//
//  DiveLogViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/9/21.
//

import UIKit
import CoreData

protocol DiveLogViewModelDelegate: AnyObject {
    func reloadTableData()
}

class DiveLogViewModel {
    var dives: [DiveModel] = []
    weak var delegate: DiveLogViewModelDelegate?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        fetchFromCoreData()
    }
    
    func addDive(dive: DiveModel) {
        dives.append(dive)
        savePersistentData()
        delegate?.reloadTableData()
    }
    
    func saveDive(dive: DiveModel, index: Int) {
        dives[index] = dive
        savePersistentData()
        delegate?.reloadTableData()
    }
    
    func getFormattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter.string(from: date)
    }
    
    private func fetchFromCoreData() {
        do {
            dives = try context.fetch(DiveModel.fetchRequest())
        } catch let error{
            print(error)
        }
    }
    
    func removePersistentData(at index: Int) {
        context.delete(dives[index])
        savePersistentData()
    }
    
    func savePersistentData() {
        do {
            try context.save()
        } catch {
            print("Error saving: \(error)")
        }
    }
    
}
