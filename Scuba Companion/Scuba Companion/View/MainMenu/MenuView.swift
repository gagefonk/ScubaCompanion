//
//  MenuView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/5/21.
//

import UIKit

class MenuView: UITabBarController {
    
    let tabs: [UIViewController] = [
        UINavigationController(rootViewController: MapView()),
        UINavigationController(rootViewController: DiveLogView(style: .insetGrouped)),
        UINavigationController(rootViewController: AccountView())
    ]
    
    let titles: [String] = [
        "Map",
        "Dives",
        "Account"
    ]
    
    let tabImages: [String] = [
        "map",
        "flag",
        "person.circle"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers(tabs, animated: false)
        self.tabBar.unselectedItemTintColor = .systemSecondary
        
        guard let items = tabBar.items else { return }
        
        for i in 0..<items.count {
            items[i].title = titles[i]
            items[i].image = UIImage(systemName: tabImages[i])
        }
        
        //set selected index for now
        self.selectedIndex = tabs.startIndex
        
        
    }
    
}
