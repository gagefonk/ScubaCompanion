//
//  RegisterViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/5/21.
//

import Foundation
import Firebase
import GoogleSignIn

protocol RegisterViewModelDelegate {
    func didCreateAccount()
}

class RegisterViewModel {
    
    var registerViewModelDelegate: RegisterViewModelDelegate?
    
    
    func createUser(name: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            if error != nil {
                print(error!)
            } else {
                if let user = result?.user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = name
                    changeRequest.commitChanges { error in
                        if let error = error {
                            print(error)
                        } else {
                            self.registerViewModelDelegate?.didCreateAccount()
                        }
                    }
                } else {
                    print("Error creating user")
                }
            }
            
        })
    }
    
    func createUser(user: GIDGoogleUser) {
        guard let idToken = user.authentication.idToken else { return }
        let accessToken = user.authentication.accessToken
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        Auth.auth().signIn(with: credentials, completion: { result, error in
            if let error = error {
                print(error)
            } else {
                self.registerViewModelDelegate?.didCreateAccount()
            }
        })
    }
    
}
