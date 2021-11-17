//
//  DivePresentationView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/15/21.
//

import UIKit

class DivePresentationView: UIViewController {
    
    //declare variables
    
    let diveLogVM: DiveLogViewModel
    let diveIndex: Int
    let mainCard = DivePresentationCard(cardType: .main)
    let waterCard = DivePresentationCard(cardType: .water)
    let weatherCard = DivePresentationCard(cardType: .weather)
    let gearCard = DivePresentationCard(cardType: .gear)
    let gasCard = DivePresentationCard(cardType: .gas)
    let otherCard = DivePresentationCard(cardType: .other)
    var cards: [UIView] = []
    
    //scrollview
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceVertical = true
        
        return scrollView
    }()
    
    let contentView = UIView()
    
    init(diveLogVM: DiveLogViewModel, diveIndex: Int){
        self.diveLogVM = diveLogVM
        self.diveIndex = diveIndex
        cards = [mainCard, waterCard, weatherCard, gearCard, gasCard, otherCard]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBackground
        view.isOpaque = false
        
        //navigation items
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editDiveButtonClicked))
        //add views
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainCard)
        contentView.addSubview(waterCard)
        contentView.addSubview(weatherCard)
        contentView.addSubview(gearCard)
        contentView.addSubview(gasCard)
        contentView.addSubview(otherCard)
        
        //populate fields
        updateView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
        
        for (index, card) in cards.enumerated() {
            card.translatesAutoresizingMaskIntoConstraints = false
            if index == 0 {
                card.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            } else {
                card.topAnchor.constraint(equalTo: cards[index - 1].bottomAnchor, constant: 20).isActive = true
            }
            if index == cards.endIndex - 1 {
                card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
            }
            card.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
            card.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    @objc private func editDiveButtonClicked() {
        let diveView = DiveView(diveLogViewModel: diveLogVM, edit: true, index: diveIndex)
        navigationController?.pushViewController(diveView, animated: true)
    }
    
    func updateView() {
        let dive = diveLogVM.dives[diveIndex]
        let date = diveLogVM.getFormattedDate(date: dive.date)
        DispatchQueue.main.async { [self] in
            //set title
            title = dive.title
            //main card
            mainCard.siteLabel.text = "Site: \(dive.site)"
            mainCard.dateLabel.text = "\(date)"
            //water card
            waterCard.diveTypeLabel.text = "Type: \(dive.diveType.rawValue)"
            waterCard.waterTypeLabel.text = "Water: \(dive.waterType.rawValue)"
            waterCard.maxDepthLabel.text = "Max: \(dive.maxDepth) ft"
            waterCard.waterBodyLabel.text = "Body: \(dive.waterBody.rawValue)"
            waterCard.bottomTimeLabel.text = "Length: \(dive.diveLength) min"
            waterCard.visLabel.text = "Vis Type: \(dive.visibility.rawValue)"
            waterCard.visInMLabel.text = "Vis: \(dive.visibilityInMeters) ft"
            waterCard.waveLabel.text = "Waves: \(dive.waves.rawValue)"
            waterCard.currentLabel.text = "Current: \(dive.current.rawValue)"
            waterCard.surgeLabel.text = "Surge: \(dive.surge.rawValue)"
            
            //weather card
            weatherCard.weatherLabel.text = "Weather: \(dive.diveWeather.rawValue)"
            weatherCard.airTempLabel.text = "Air: \(dive.airTemp) F"
            weatherCard.surfaceTempLabel.text = "Surface: \(dive.surfaceTemp) F"
            weatherCard.bottomTempLabel.text = "Bottom: \(dive.bottomTemp) F"
            
            //gear card
            gearCard.suitLabel.text = "Suit Type: \(dive.suitType.rawValue)"
            gearCard.weightLabel.text = "Weight: \(dive.weight) lbs"
            gearCard.tankTypeLabel.text = "Tank: \(dive.tankType.rawValue)"
            gearCard.tankSizeLabel.text = "Tank Size: \(dive.tankSize) L"
            
            //gas card
            gasCard.gasLabel.text = "Gas: \(dive.gasMixture.rawValue)"
            gasCard.oxygenLabel.text = "Oxygen: \(dive.oxygen) %"
            gasCard.nitrogenLabel.text = "Nitrogen: \(dive.nitrogen) %"
            gasCard.heliumLabel.text = "Helium: \(dive.helium) %"
            gasCard.startPressureLabel.text = "Start: \(dive.startPressure) PSI"
            gasCard.endPressureLabel.text = "End: \(dive.endPressure) PSI"
            gasCard.amountUsedLabel.text = "Amount Used: \(dive.amountUsed) PSI"
            
            //other card
           otherCard.buddyLabel.text = "Buddies: \(dive.diveBuddy)"
           otherCard.centerLabel.text = "Dive Center: \(dive.diveCenter)"
           otherCard.noteLabel.text = "Notes: \(dive.note)"
        }
    }
    
}
