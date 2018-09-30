//
//  CountryViewModel.swift
//  Countries
//
//  Created by Anastasia Loginova on 9/30/18.
//  Copyright © 2018 loginova. All rights reserved.
//

import Foundation

final class CountryViewModel {
    var details: String
    
    init() {
        self.details = ""
    }
    
    init(country: Country) {
        var details = ""
//        details.append("\(country.name)\n\n")
        details.append("Capital: ")
        details.append("\(country.capital)\n\n")
        details.append("Population: ")
        details.append("\(country.population)\n\n")
        
        if country.borders.count > 0 {
            details.append("Borders: ")
            country.borders.forEach { border in
                details.append(contentsOf: "\(border), ")
            }
            
            details = String(details.dropLast(2))
        } else {
            details.append("No borders")
        }
        
        details.append("\n\nCurrencies: ")
        country.currencies.forEach({
            details.append("\($0.name) with code \($0.code)\n")
        })
        
        self.details = details
    }
}
