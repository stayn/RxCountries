//
//  CountryDetailViewModel.swift
//  Countries
//
//  Created by Anastasia Loginova on 9/30/18.
//  Copyright © 2018 loginova. All rights reserved.
//

import Foundation
import RxSwift

final class CountryDetailViewModel {
    var name = ""
    var country: Variable<CountryViewModel> = Variable(CountryViewModel())
    let service = DataManager()
    var error: Variable<String> = Variable("")
    private var disposeBag = DisposeBag()
    
    func fetchCountryDetails() {
        service.fetchCountryDetails(name: name)
            .map {country in
                CountryViewModel(country: country.first!)}
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (viewModel) in
                self.country.value = viewModel
            }, onError: { (error) in
                self.error.value = error.localizedDescription
            }, onCompleted: {
                print(self.country.value.details)
            }).disposed(by: disposeBag)
    }
}
