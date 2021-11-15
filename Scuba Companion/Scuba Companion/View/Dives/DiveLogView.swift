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
        
        title = "Dives"
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diveLogVM.dives.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = diveLogVM.dives[indexPath.row].title
        cell.detailTextLabel?.text = diveLogVM.dives[indexPath.row].site
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let index = indexPath.row
        let diveView = DiveView(diveLogViewModel: diveLogVM, dive: diveLogVM.dives[index], edit: true, index: index)
        diveView.modalPresentationStyle = .popover
        self.present(UINavigationController(rootViewController: diveView), animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            diveLogVM.dives.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @objc func addDiveButtonClicked() {
        let diveView = DiveView(diveLogViewModel: diveLogVM, dive: nil, edit: false, index: 0)
        diveView.modalPresentationStyle = .popover
        self.present(UINavigationController(rootViewController: diveView), animated: true, completion: nil)
        
    }
    
}

extension DiveLogView: DiveLogViewModelDelegate {
    
    func reloadTableData() {
        tableView.reloadData()
    }
}
