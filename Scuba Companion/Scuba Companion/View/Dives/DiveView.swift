//
//  DiveView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/10/21.
//

import UIKit

class DiveView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem = UITabBarItem(title: "Dives", image: UIImage(systemName: "flag"), tag: 1)
    
    }

}

enum CustomColor {
    case blueberry
}

class test {
    var bgColor: CustomColor?
    
    
}
