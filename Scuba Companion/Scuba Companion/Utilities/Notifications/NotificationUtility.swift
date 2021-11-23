//
//  NotificationUtility.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/15/21.
//

import UIKit

struct NotificationUtility {
    
    func getAlert(title: String, error: Error) -> UIAlertController {
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        return alert
        
    }
}

