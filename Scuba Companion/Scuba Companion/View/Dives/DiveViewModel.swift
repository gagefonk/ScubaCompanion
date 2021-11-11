//
//  DiveViewModel.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/9/21.
//

import Foundation
import UIKit

class DiveViewModel {
    
    let diveForms = DiveLogForms()
    var diveCards: [UIView] = []
    
    init() {
        
        populateFormCards(diveFormData: diveForms.forms)
    }
    
    private func populateFormCards(diveFormData: [DiveLogCard]) {
        diveFormData.forEach { form in
            switch form.group {
            case .input:
                let cardView = DiveLogInputCard()
                cardView.configureCard(charType: form.textType, title: form.title, subtitle: form.subtitle, units: form.units, placeholder: form.placeholder)
                diveCards.append(cardView)
            case .date:
                let cardView = DiveLogDateCard()
                cardView.configureCard(title: form.title, subtitle: form.subtitle)
                diveCards.append(cardView)
            case .typeInput:
                let cardView = DiveLogTypeCard()
                cardView.configureCard(title: form.title, subtitle: form.subtitle, type: form.inputType)
                diveCards.append(cardView)
            }
        }
    }
}
