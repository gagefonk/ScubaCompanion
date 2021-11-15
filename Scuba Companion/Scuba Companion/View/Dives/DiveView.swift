//
//  DiveView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/10/21.
//

import UIKit

class DiveView: UIViewController {
    
    let diveVM: DiveViewModel
    let diveLogVM: DiveLogViewModel
    let notificationUtility = NotificationUtility()
    var isEditingDive: Bool = false
    var editingIndex: Int = 0
    
     let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceVertical = true
        
        return scrollView
    }()
    
    let contentView = UIView()
    
    init(diveLogViewModel: DiveLogViewModel, dive: Dive?, edit: Bool, index: Int) {
        self.diveLogVM = diveLogViewModel
        self.diveVM = DiveViewModel(diveLogViewModel: diveLogVM, dive: dive)
        self.isEditingDive = edit
        self.editingIndex = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBackground
        
        //navigation items
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonClicked))
        if isEditingDive {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonClicked))
            title = "Edit Dive"
        }else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
            title = "New Dive"
        }
        
        //gesture for end editing
        let tapToEndEditing = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardWhenTapped))
        tapToEndEditing.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapToEndEditing)
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        for (index, card) in diveVM.diveCards.enumerated() {
            contentView.addSubview(card)
            layoutCards(index: index, card: card)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc private func cancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func addButtonClicked() {
        diveVM.createDiveLog(with: .add, index: nil) { err in
            if let err = err {
                let alert = notificationUtility.getAlert(messageType: err)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @objc private func saveButtonClicked() {
        diveVM.createDiveLog(with: .save, index: editingIndex) { err in
            if let err = err {
                let alert = notificationUtility.getAlert(messageType: err)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc private func hideKeyboardWhenTapped() {
        self.view.endEditing(true)
    }
    
    private func layoutCards(index: Int, card: UIView){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        card.translatesAutoresizingMaskIntoConstraints = false
        if index == 0 {
            card.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        } else {
            card.topAnchor.constraint(equalTo: diveVM.diveCards[index - 1].bottomAnchor, constant: 20).isActive = true
        }
        if index == diveVM.diveCards.endIndex - 1 {
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        }
        card.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        card.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true

        //bg design
        //other view design stuff
        card.backgroundColor = .systemGray5
        card.layer.cornerRadius = 15
        card.layer.borderWidth = 0.5
        card.layer.borderColor = UIColor.black.cgColor
        //shadow
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 1
        card.layer.shadowOffset = .zero
        card.layer.shadowRadius = 10

    }
}
