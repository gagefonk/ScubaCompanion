//
//  DiveView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/10/21.
//

import UIKit

class DiveView: UIViewController {
    
    //create UI elements
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        
        return scrollView
    }()
    //dive title
    let diveTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Dive Title"
        label.textColor = .white
        
        return label
    }()
    
    let diveTitleTextfield: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.layer.cornerRadius = 4
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 2.0
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Dive Title", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
        
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBackground
        
        //add views
        view.addSubview(scrollView)
        scrollView.addSubview(diveTitleLabel)
        scrollView.addSubview(diveTitleTextfield)
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //get width of screen for autolayout purposes
        let width = UIScreen.main.bounds.width
        let center = view.centerXAnchor
        
        //scrollview
        scrollView.frame = view.bounds
        
        //dive title
        diveTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        diveTitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100).isActive = true
        diveTitleLabel.centerXAnchor.constraint(equalTo: center).isActive = true
        
        diveTitleTextfield.translatesAutoresizingMaskIntoConstraints = false
        diveTitleTextfield.topAnchor.constraint(equalTo: diveTitleLabel.bottomAnchor, constant: 20).isActive = true
        diveTitleTextfield.centerXAnchor.constraint(equalTo: center).isActive = true
        diveTitleTextfield.widthAnchor.constraint(equalToConstant: width * 0.8).isActive = true
        
    }

}
