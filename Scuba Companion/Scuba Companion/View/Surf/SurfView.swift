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
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        for card in surfVM.surfCards {
            contentView.addSubview(card)
        }
        
        animateRings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let leftPadding: CGFloat = 20
        let rightPadding: CGFloat = -20
        let topPadding: CGFloat = 10
        let bottomPadding: CGFloat = -20
        
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
            if index == 0 {
                card.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            } else {
                card.topAnchor.constraint(equalTo: surfVM.surfCards[index - 1].bottomAnchor, constant: topPadding).isActive = true
            }
            if index == surfVM.surfCards.endIndex - 1 {
                card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bottomPadding).isActive = true
            }
            card.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: leftPadding).isActive = true
            card.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: rightPadding).isActive = true
        }
    }
    
    func animateRings() {
        for card in surfVM.surfCards {
            card.progressView?.animateProgress()
        }
    }
    
    func updateView() {
        //fill the data
    }
}
