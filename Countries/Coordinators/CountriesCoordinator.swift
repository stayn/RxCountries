//
//  CountryCoordinator.swift
//  Countries
//
//  Created by Anastasia Loginova on 9/20/18.
//  Copyright © 2018 loginova. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class CountriesCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = CountriesViewModel()
        let viewController = CountriesViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.viewModel = viewModel
        
        viewModel.didSelectCountry
            .subscribe({[weak self] in self?.showCountry(with: $0.element ?? "Russia", in: navigationController)})
            .disposed(by: disposeBag)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
    
    private func showCountry(with name: String, in navigationController: UINavigationController) {
        let viewController = CountryDetailViewController()
        viewController.viewModel.name = name
        navigationController.pushViewController(viewController, animated: true)
    }
}
