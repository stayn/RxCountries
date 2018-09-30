//
//  CountryViewModel.swift
//  Countries
//
//  Created by Anastasia Loginova on 9/20/18.
//  Copyright © 2018 loginova. All rights reserved.
//

import Foundation
import RxSwift
import Moya

final class CountriesViewModel {
    let service = DataManager()
    var countriesViewModels: Variable<[CountryList]> = Variable([])
    var error: Variable<String> = Variable("")
    private var disposeBag = DisposeBag()
    
    let selectCountry: AnyObserver<CountryList>
    
    var didSelectCountry: Observable<String>
    
    init() {
        let _selectCountry = PublishSubject<CountryList>()
        self.selectCountry = _selectCountry.asObserver()
        self.didSelectCountry = _selectCountry.asObservable()
            .map { $0.name }
    }
    
    func fetchCountries() {
        service.fetchCountries()
            .map { countries in countries.map(CountryList.init)}
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (viewModels) in
                self.countriesViewModels.value = viewModels
            }, onError: { (error) in
                print(error.localizedDescription)
                self.error.value = error.localizedDescription
            }, onCompleted: {
            }, onDisposed: {
            })
            .disposed(by: disposeBag)
    }
}




