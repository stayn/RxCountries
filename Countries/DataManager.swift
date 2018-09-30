//
//  DataManager.swift
//  Countries
//
//  Created by Anastasia Loginova on 9/30/18.
//  Copyright © 2018 loginova. All rights reserved.
//

import Foundation
import RxSwift
import Moya

struct DataManager {
    let provider = MoyaProvider<NetworkManager>()
    
    func fetchCountries() -> Observable<[CountryList]> {
        return self.provider.rx
            .request(NetworkManager.all)
            .map([CountryList].self).asObservable()
            .retry(1)
    }
    
    func fetchCountryDetails(name: String) -> Observable<[Country]> {
        return self.provider.rx
            .request(NetworkManager.detail(name: name))
            .map([Country].self).asObservable()
            .retry(1)
    }
}
