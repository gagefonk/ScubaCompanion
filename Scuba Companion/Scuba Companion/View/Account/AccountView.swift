//
//  AccountView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/10/21.
//

import UIKit
import Firebase

class AccountView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person"), tag: 2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    func setupLayout() {
        
        //naviagation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(logout))
    }
    
    @objc private func logout() {
        if Auth.auth().currentUser != nil {
            try? Auth.auth().signOut()
        }
        let loginView = LoginView()
        loginView.modalPresentationStyle = .fullScreen
        self.present(loginView, animated: true, completion: nil)
    }

}
