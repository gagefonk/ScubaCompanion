//
//  DiveView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/10/21.
//

import UIKit

enum DiveError: LocalizedError {
    case title, add, save
    
    var errorDescription: String? {
        switch self {
        case .title:
            return NSLocalizedString("Dive is missing the title.", comment: "")
        case .add:
            return NSLocalizedString("Unable to add dive.", comment: "")
        case .save:
            return NSLocalizedString("Unable to save dive.", comment: "")
        }
    }
}

class DiveView: UIViewController {
    
    let diveVM: DiveViewModel
    let diveLogVM: DiveLogViewModel
    let notificationUtility = NotificationUtility()
    var isEditingDive: Bool = false
    var editingIndex: Int?
    
     let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceVertical = true
        
        return scrollView
    }()
    
    let contentView = UIView()
    
    init(diveLogViewModel: DiveLogViewModel, edit: Bool, index: Int?) {
        self.diveLogVM = diveLogViewModel
        self.diveVM = DiveViewModel(diveLogViewModel: diveLogVM, index: index ?? nil)
        self.isEditingDive = edit
        self.editingIndex = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        self.view.backgroundColor = .darkBackground
        
        //keyboard observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        for (index, card) in diveVM.diveCards.enumerated() {
            contentView.addSubview(card)
            layoutCards(index: index, card: card)
        }
    }
    
    @objc private func cancelButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addButtonClicked() {
        diveVM.createDiveLog(with: .add, index: nil) { [weak self] err in
            guard let self = self, let err = err else {
                navigationController?.popViewController(animated: true)
                return
            }
            let alert = notificationUtility.getAlert(title: "Add Error", error: err)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func saveButtonClicked() {
        diveVM.createDiveLog(with: .save, index: editingIndex) { [weak self] err in
            guard let self = self, let err = err else {
                navigationController?.popViewController(animated: true)
                return
            }
            let alert = notificationUtility.getAlert(title: "Save Error", error: err)
            self.present(alert, animated: true, completion: nil)
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
            card.topAnchor.constraint(equalTo: diveVM.diveCards[index - 1].bottomAnchor, constant: 10).isActive = true
        }
        if index == diveVM.diveCards.endIndex - 1 {
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        }
        card.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        card.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true

    }
    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = .zero
        scrollView.contentInset = contentInset
    }
}
