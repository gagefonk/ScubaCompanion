//
//  SurfView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/17/21.
//

import UIKit

class SurfView : UIViewController {
    
    let surfVM = SurfViewModel()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceVertical = true
        
        return scrollView
    }()
    
    let contentView = UIView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Surf Forecast"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.sizeToFit()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        for card in surfVM.surfCards {
            contentView.addSubview(card)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let leftPadding: CGFloat = 10
        let leftHalfPadding: CGFloat = 5
        let rightPadding: CGFloat = -10
        let rightHalfPadding: CGFloat = -5
        let topPadding: CGFloat = 10
        let bottomPadding: CGFloat = -10
        
        //constrain scroll
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
        
        for (index, card) in surfVM.surfCards.enumerated() {
            card.translatesAutoresizingMaskIntoConstraints = false
            switch card.type {
            case .date:
                card.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: topPadding).isActive = true
                card.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftPadding).isActive = true
                card.rightAnchor.constraint(equalTo: view.rightAnchor, constant: rightPadding).isActive = true
            default:
                if index == 0 || index == 1 {
                    if surfVM.surfCards[0].type == .date{
                        card.topAnchor.constraint(equalTo: surfVM.surfCards[0].bottomAnchor, constant: topPadding).isActive = true
                    } else {
                        card.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
                    }
                } else {
                    card.topAnchor.constraint(equalTo: surfVM.surfCards[index - 2].bottomAnchor, constant: topPadding).isActive = true
                }
                if index == surfVM.surfCards.endIndex - 1 {
                    card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bottomPadding).isActive = true
                }
    
                if index % 2 != 0 {
                    card.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: leftPadding).isActive = true
                    card.rightAnchor.constraint(equalTo: contentView.centerXAnchor, constant: rightHalfPadding).isActive = true
                } else {
                    card.leftAnchor.constraint(equalTo: contentView.centerXAnchor, constant: leftHalfPadding).isActive = true
                    card.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: rightPadding).isActive = true
                }
            }
        }
    }
    
    func updateView() {
        //fill the data
    }
}
