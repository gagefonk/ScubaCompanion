//
//  NotificationUtility.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/15/21.
//

import UIKit

enum NotificationErrorType: Error {
    case network, missingTitle
}

struct NotificationUtility {
    
    func getAlert(messageType: NotificationErrorType) -> UIAlertController {
        let title: String
        let message: String
        
        switch messageType {
        case .network:
            title = "Network Error"
            message = "Error with network call"
        case .missingTitle:
            title = "Missing Title"
            message = "Please enter a dive title"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        return alert
        
    }
}

