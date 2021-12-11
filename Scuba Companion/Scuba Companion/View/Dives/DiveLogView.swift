//
//  DiveLogView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/8/21.
//

import UIKit

class DiveLogView: UITableViewController {
    
    let diveLogVM = DiveLogViewModel()
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        
        tableView.frame = view.bounds
        
        self.navigationItem.title = "Dives"
        self.view.backgroundColor = .darkBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        tabBarItem = UITabBarItem(title: "Dives", image: UIImage(systemName: "flag"), tag: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDiveButtonClicked))
        
        tableView.register(DiveLogCell.self, forCellReuseIdentifier: "cell")
        
        diveLogVM.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkBackground
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diveLogVM.dives.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dive = diveLogVM.dives[indexPath.row]
        cell.tintColor = .systemSecondary
        cell.textLabel?.text = dive.title
        cell.detailTextLabel?.text = diveLogVM.getFormattedDate(date: dive.date!)
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        cell.backgroundColor = .surfaceBackground
        let chevron = UIImage(systemName: "chevron.right")
        cell.accessoryView = UIImageView(image: chevron)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let index = indexPath.row
        let divePresentation = DivePresentationView(diveLogVM: diveLogVM, diveIndex: index)
        navigationController?.pushViewController(divePresentation, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            diveLogVM.removePersistentData(at: indexPath.row)
            diveLogVM.dives.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @objc func addDiveButtonClicked() {
        let diveView = DiveView(diveLogViewModel: diveLogVM, edit: false, index: nil)
        navigationController?.pushViewController(diveView, animated: true)
        
    }
    
}

extension DiveLogView: DiveLogViewModelDelegate {
    
    func reloadTableData() {
        tableView.reloadData()
    }
}
