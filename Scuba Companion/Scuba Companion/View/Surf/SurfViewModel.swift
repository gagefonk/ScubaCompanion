//
//  SurfViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/18/21.
//

import Foundation

class SurfViewModel {
    
    var surfCards: [SurfPresentationCard] = []
    let surfDisplayData = SurfDisplayData()
    
    init() {
        surfCards = surfDisplayData.surfCards
    }
}
