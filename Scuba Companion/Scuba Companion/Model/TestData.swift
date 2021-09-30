//
//  TestData.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/11/21.
//

import Foundation
import CoreLocation


struct TestData {
    
}

struct DivePin {
    let pinLocation: CLLocationCoordinate2D?
    let title: String?
    
    init(pinLocation: CLLocationCoordinate2D, title: String) {
        self.pinLocation = pinLocation
        self.title = title
    }
}
