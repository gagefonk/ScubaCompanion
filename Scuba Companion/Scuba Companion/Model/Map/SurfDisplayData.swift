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
        let dateCard = SurfPresentationCard(type: .date, date: "12/01/21", id: "date")
        let testProgress = SurfPresentationCard(type: .progress, title: "Test", subtitle: "test", maxValue: 100, value: 50, id: "test")
        let testProgress1 = SurfPresentationCard(type: .progress, title: "Test", subtitle: "test", maxValue: 75, value: 30, id: "test2")
        let testProgress3 = SurfPresentationCard(type: .progress, title: "Test Three", subtitle: "This is the third test", maxValue: 175, value: 30, id: "test3")
        let testProgress4 = SurfPresentationCard(type: .progress, title: "Test", subtitle: "test", maxValue: 100, value: 50, id: "test")
        let testProgress5 = SurfPresentationCard(type: .progress, title: "Test", subtitle: "test", maxValue: 75, value: 30, id: "test2")
        
        surfCards.append(dateCard)
        surfCards.append(testProgress)
        surfCards.append(testProgress1)
        surfCards.append(testProgress3)
        surfCards.append(testProgress4)
        surfCards.append(testProgress5)
    }
}
