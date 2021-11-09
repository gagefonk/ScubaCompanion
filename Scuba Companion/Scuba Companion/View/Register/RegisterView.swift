//
//  RegisterView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/5/21.
//

import UIKit
import GoogleSignIn

class RegisterView: UIViewController {
    
    let registerViewModel = RegisterViewModel()
    let customGoogleConfig = CustomGoogleConfig()
    
    let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.font = .systemFont(ofSize: 40)
        label.textColor = .systemGreen

        return label
    }()
    
    let nameTextField: UITextField = {
       let nameTextField = UITextField()
        nameTextField.borderStyle = .roundedRect
        nameTextField.autocorrectionType = .no
        nameTextField.backgroundColor = UIColor(named: "textFieldBackground")
        nameTextField.textColor = .white
        nameTextField.autocapitalizationType = .words
        nameTextField.returnKeyType = .done
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        
        return nameTextField
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
    
    let createButton: UIButton = {
        let createButton = UIButton()
        createButton.setTitle("Create Account", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.layer.cornerRadius = 5
        createButton.backgroundColor = .systemGreen
        createButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        
        return createButton
    }()
    
    let menuDivider: UIView = {
        let menuDivider = UIView()
        menuDivider.backgroundColor = .divider
        
        return menuDivider
    }()
    
    let googleSignIn: GIDSignInButton = {
        let googleSignIn = GIDSignInButton()
        googleSignIn.colorScheme = .dark
        googleSignIn.style = .wide
        googleSignIn.addTarget(self, action: #selector(gSignIn), for: .touchUpInside)
        return googleSignIn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        registerViewModel.registerViewModelDelegate = self
        
        view.backgroundColor = .darkBackground
        
        view.addSubview(registerLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(createButton)
        view.addSubview(menuDivider)
        view.addSubview(googleSignIn)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupLayout()
    }
    
    func setupLayout() {
        
        //label layout
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        //name layout
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: 40).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //email layout
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //password layout
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //button layout
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40).isActive = true
        createButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        createButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier: 0.5).isActive = true
        
        //divider layout
        menuDivider.translatesAutoresizingMaskIntoConstraints = false
        menuDivider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuDivider.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 30).isActive = true
        menuDivider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75).isActive = true
        menuDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //GOOGLE SIGN IN BUTTON
        googleSignIn.translatesAutoresizingMaskIntoConstraints = false
        googleSignIn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        googleSignIn.topAnchor.constraint(equalTo: menuDivider.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc func createAccount() {
        guard let name = nameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        registerViewModel.createUser(name: name, email: email, password: password)
    }
    
    @objc func gSignIn() {
        GIDSignIn.sharedInstance.signIn(with: customGoogleConfig.signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let googleUser = user else { return }
            self.registerViewModel.createUser(user: googleUser)
        }
    }
    
}

extension RegisterView: RegisterViewModelDelegate {
    
    func didCreateAccount() {
        let menuView = MenuView()
        menuView.modalPresentationStyle = .fullScreen
        present(menuView, animated: true, completion: nil)
    }
    
}
