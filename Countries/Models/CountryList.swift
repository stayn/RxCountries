//
//  CountryList.swift
//  Countries
//
//  Created by Anastasia Loginova on 9/30/18.
//  Copyright © 2018 loginova. All rights reserved.
//

import Foundation

struct CountryList: Decodable {
    let name: String
    let population: Int
    
    init(country: CountryList) {
        self.name = country.name
        self.population =  country.population
    }
}
