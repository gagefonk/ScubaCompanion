//
//  LoginView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/5/21.
//

import UIKit
import GoogleSignIn

class LoginView: UIViewController, LoginViewModelDelegate {
    
    //declare variables
    let loginVM = LoginViewModel()
    let customGoogleConfig = CustomGoogleConfig()
    
    let menuLogo: UIImageView = {
        let menuLogo = UIImageView()
        menuLogo.tintColor = .white
        menuLogo.image = UIImage(named: "diveLogo")
        
        return menuLogo
    }()
    
    let loginText: UILabel = {
        let loginText = UILabel()
        loginText.text = "Scuba Companion"
        loginText.font = .systemFont(ofSize: 40)
        loginText.textColor = .systemGreen
        loginText.numberOfLines = -1
        
        return loginText
    }()
    
    let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocorrectionType = .no
        emailTextField.backgroundColor = UIColor(named: "textFieldBackground")
        emailTextField.textColor = .white
        emailTextField.autocapitalizationType = .none
        emailTextField.returnKeyType = .done
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        
        return emailTextField
    }()
    
    let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocorrectionType = .no
        passwordTextField.backgroundColor = UIColor(named: "textFieldBackground")
        passwordTextField.textColor = .white
        passwordTextField.returnKeyType = .done
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        
        return passwordTextField
    }()
    
    let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemGreen
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        return loginButton
    }()
    
    let registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.setTitle("Create Account", for: .normal)
        registerButton.setTitleColor(.cyan, for: .normal)
        registerButton.backgroundColor = .clear
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        return registerButton
    }()
    
    let menuDivider: UIView = {
        let menuDivider = UIView()
        menuDivider.backgroundColor = UIColor(named: "divider")
        
        return menuDivider
    }()
    
    let googleSignIn: GIDSignInButton = {
        let googleSignIn = GIDSignInButton()
        googleSignIn.colorScheme = .dark
        googleSignIn.style = .wide
        googleSignIn.addTarget(self, action: #selector(gSignIn), for: .touchUpInside)
        return googleSignIn
    }()
    
    //view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginVM.loginViewModelDelegate = self
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.backgroundColor = .darkBackground
        
        //add subviews
        view.addSubview(menuLogo)
        view.addSubview(loginText)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        view.addSubview(menuDivider)
        view.addSubview(googleSignIn)
    }
    
    //setup layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupLayout()
    }
    
    //setup menu items
    private func setupLayout() {
        
        //logo layout
        menuLogo.translatesAutoresizingMaskIntoConstraints = false
        menuLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        menuLogo.heightAnchor.constraint(equalToConstant: 200).isActive = true
        menuLogo.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        //text layout
        loginText.translatesAutoresizingMaskIntoConstraints = false
        loginText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginText.topAnchor.constraint(equalTo: menuLogo.bottomAnchor, constant: 40).isActive = true
        
        //email textfield layout
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: loginText.bottomAnchor, constant: 50).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //password textfield layout
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //login button layout
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier: 0.5).isActive = true
        
        //register button layout
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        registerButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier: 0.5).isActive = true
        
        //divider layout
        menuDivider.translatesAutoresizingMaskIntoConstraints = false
        menuDivider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuDivider.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10).isActive = true
        menuDivider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        menuDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //GOOGLE SIGN IN BUTTON
        googleSignIn.translatesAutoresizingMaskIntoConstraints = false
        googleSignIn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        googleSignIn.topAnchor.constraint(equalTo: menuDivider.bottomAnchor, constant: 20).isActive = true
        
        
    }
    
    @objc func login(_ sender: Any) {
        loginVM.login(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @objc func register(_ sender: Any) {
        let registerView = RegisterView()
        registerView.modalPresentationStyle = .fullScreen
        present(registerView, animated: true, completion: nil)
        
    }
    
    @objc func gSignIn() {
        GIDSignIn.sharedInstance.signIn(with: customGoogleConfig.signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let googleUser = user else { return }
            self.loginVM.login(user: googleUser)
        }
    }
    
    func didSignIn() {
        let menuView = MenuView()
        menuView.modalPresentationStyle = .fullScreen
        present(menuView, animated: true, completion: nil)
    }
    
}
