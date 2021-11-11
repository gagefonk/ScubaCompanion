//
//  DiveView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 8/10/21.
//

import UIKit

class DiveView: UIViewController {
    
    let diveVM = DiveViewModel()
    
     let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceVertical = true
        
        return scrollView
    }()
    
    let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBackground
        
        //navigation items
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonClicked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addButtonClicked))
        title = "New Dive"
        
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
        self.dismiss(animated: true, completion: nil)
    }
    
    private func layoutCards(index: Int, card: UIView){
//        scrollView.frame = view.frame
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
