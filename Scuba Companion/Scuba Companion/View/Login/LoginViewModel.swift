//
//  LoginViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/5/21.
//

import UIKit
import GoogleSignIn
import Firebase

protocol LoginViewModelDelegate {
    func didSignIn()
}

class LoginViewModel {
    
    var loginViewModelDelegate: LoginViewModelDelegate?
    
    //handle login information here
    func login(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
            if let error = error {
                print(error)
            } else {
                self.loginViewModelDelegate?.didSignIn()
            }
            
        })
    }
    
    func login(user: GIDGoogleUser){
        guard let idToken = user.authentication.idToken else { return }
        let accessToken = user.authentication.accessToken
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        Auth.auth().signIn(with: credentials, completion: { result, error in
            if let error = error {
                print(error)
            } else {
                self.loginViewModelDelegate?.didSignIn()
            }
        })
    }
    
}
