//
//  DiveLogView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/8/21.
//

import UIKit

class DiveLogView: UITableViewController {
    var dives: [Dive] = []
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        
        tableView.frame = view.bounds
        
        title = "Dives"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        tabBarItem = UITabBarItem(title: "Dives", image: UIImage(systemName: "flag"), tag: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDive))
        
        tableView.register(DiveLogCell.self, forCellReuseIdentifier: "cell")
        
        addData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dives.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dives[indexPath.row].title
        cell.detailTextLabel?.text = dives[indexPath.row].site
        cell.accessoryType = .detailButton
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print(dives[indexPath.row].title)
    }
    
    @objc func addDive() {
        let diveView = DiveView()
        self.modalPresentationStyle = .overFullScreen

        self.present(diveView, animated: true, completion: nil)
    }
    
    func addData() {
        for _ in 0...19 {
            let dive = Dive(title: "La Jolla", site: "La Jolla", diveType: .shore, maxDepth: 30, diveLength: 30, waterType: .salt, waterBody: .ocean, diveWeather: .sun, airTemp: 70, surfaceTemp: 70, bottomTemp: 70, visibility: .high, visibilityInMeters: 30, waves: .none, current: .none, surge: .light, suitType: .sevenmm, weight: 25, tankType: .aluminum, tankSize: 80, gasMixture: .air, oxygen: 95, nitrogen: 0, helium: 0, startPressure: 3000, endPressure: 300, note: "", diveBuddy: ["Rob"], diveCenter: "None")
            dives.append(dive)
        }
    }
}
