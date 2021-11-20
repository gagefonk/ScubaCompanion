//
//  SurfDisplayData.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/17/21.
//

import Foundation

class SurfDisplayData {
    
    var surfCards: [SurfPresentationCard] = []
    
    init() {
        let testProgress = SurfPresentationCard(type: .progress, title: "Test", subtitle: "test", maxValue: 100, value: 50, id: "test")
        let testProgress1 = SurfPresentationCard(type: .progress, title: "Test", subtitle: "test", maxValue: 75, value: 30, id: "test")
        
        surfCards.append(testProgress)
        surfCards.append(testProgress1)
    }
}
