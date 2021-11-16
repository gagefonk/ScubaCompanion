//
//  DummyData.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/15/21.
//

import Foundation

struct DummyData {
    var dives: [Dive] = []
    
    init() {
        dives.append(Dive(title: "La Jolla", site: "Shores", date: Date(), diveType: .shore, maxDepth: "20", diveLength: "45", waterType: .salt, waterBody: .ocean, diveWeather: .sun, airTemp: "70", surfaceTemp: "70", bottomTemp: "68", visibility: .high, visibilityInMeters: "15", waves: .none, current: .none, surge: .light, suitType: .sevenmm, weight: "25", tankType: .aluminum, tankSize: "80", gasMixture: .air, oxygen: "0", nitrogen: "0", helium: "0", startPressure: "3000", endPressure: "300", amountUsed: "", note: "This is a note", diveBuddy: "Shay Rosebery", diveCenter: ""))
        
        dives.append(Dive(title: "La Jolla", site: "Shores", date: Date(), diveType: .shore, maxDepth: "20", diveLength: "45", waterType: .salt, waterBody: .ocean, diveWeather: .sun, airTemp: "70", surfaceTemp: "70", bottomTemp: "68", visibility: .high, visibilityInMeters: "15", waves: .none, current: .none, surge: .light, suitType: .sevenmm, weight: "25", tankType: .aluminum, tankSize: "80", gasMixture: .air, oxygen: "0", nitrogen: "0", helium: "0", startPressure: "3000", endPressure: "300", amountUsed: "2700", note: "This is a note", diveBuddy: "Shay Rosebery", diveCenter: ""))
        
        dives.append(Dive(title: "La Jolla", site: "Shores", date: Date(), diveType: .shore, maxDepth: "20", diveLength: "45", waterType: .salt, waterBody: .ocean, diveWeather: .sun, airTemp: "70", surfaceTemp: "70", bottomTemp: "68", visibility: .high, visibilityInMeters: "15", waves: .none, current: .none, surge: .light, suitType: .sevenmm, weight: "25", tankType: .aluminum, tankSize: "80", gasMixture: .air, oxygen: "0", nitrogen: "0", helium: "0", startPressure: "3000", endPressure: "300", amountUsed: "2700", note: "This is a note", diveBuddy: "Shay Rosebery", diveCenter: ""))
        
        dives.append(Dive(title: "La Jolla", site: "Shores", date: Date(), diveType: .shore, maxDepth: "20", diveLength: "45", waterType: .salt, waterBody: .ocean, diveWeather: .sun, airTemp: "70", surfaceTemp: "70", bottomTemp: "68", visibility: .high, visibilityInMeters: "15", waves: .none, current: .none, surge: .light, suitType: .sevenmm, weight: "25", tankType: .aluminum, tankSize: "80", gasMixture: .air, oxygen: "0", nitrogen: "0", helium: "0", startPressure: "3000", endPressure: "300", amountUsed: "2700", note: "This is a note", diveBuddy: "Shay Rosebery", diveCenter: ""))
        
        dives.append(Dive(title: "La Jolla", site: "Shores", date: Date(), diveType: .shore, maxDepth: "20", diveLength: "45", waterType: .salt, waterBody: .ocean, diveWeather: .sun, airTemp: "70", surfaceTemp: "70", bottomTemp: "68", visibility: .high, visibilityInMeters: "15", waves: .none, current: .none, surge: .light, suitType: .sevenmm, weight: "25", tankType: .aluminum, tankSize: "80", gasMixture: .air, oxygen: "0", nitrogen: "0", helium: "0", startPressure: "3000", endPressure: "300", amountUsed: "2700", note: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque massa augue, elementum eu ultrices id, vestibulum id enim. Vestibulum egestas sodales neque. Curabitur ex purus, feugiat vitae mauris ac, efficitur dapibus risus. Nam tincidunt aliquet eleifend. Aliquam ullamcorper nisi eu accumsan posuere. In a porttitor massa. In hac habitasse platea dictumst. Ut cursus erat quam, nec pulvinar augue tempus finibus.", diveBuddy: "Shay Rosebery", diveCenter: ""))
    }
}
