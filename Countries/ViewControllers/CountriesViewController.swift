//
//  CountriesViewController.swift
//  Countries
//
//  Created by Anastasia Loginova on 9/20/18.
//  Copyright © 2018 loginova. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CountriesViewController: UIViewController {
    @IBOutlet weak var countriesTableView: UITableView!
    
    var viewModel = CountriesViewModel()
    private var disposeBag = DisposeBag()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        
        self.navigationItem.title = "Countries"
        
        countriesTableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "countryCell")
        countriesTableView.insertSubview(refreshControl, at: 0)

        refreshControl.sendActions(for: .valueChanged)
    }
    
    private func setupBindings() {
        viewModel.countriesViewModels.asObservable()
            .do(onNext: { [weak self] _  in
                self?.refreshControl.endRefreshing()
                }, onError: { (error) in
                    print(error)
            }, onCompleted: {
            }, onSubscribe: {
            }, onSubscribed: {
            }, onDispose: {
            })
            .bind(to: countriesTableView.rx.items(cellIdentifier: "countryCell",
                                         cellType: CountryTableViewCell.self))
            { (_, viewModel, cell) in
                self.setupCell(cell, viewModel: viewModel)
                
            }.disposed(by: disposeBag)
        
        countriesTableView.rx.modelSelected(CountryList.self)
            .bind(to: viewModel.selectCountry)
            .disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.valueChanged)
            .subscribe({ [weak self] _ in self?.viewModel.fetchCountries() })
            .disposed(by: disposeBag)
        
        viewModel.error.asObservable()
            .skip(1)
            .bind { [weak self] (errorText) in
                self?.showAlert(message: errorText)
            }.disposed(by: disposeBag)
    }

    private func setupCell(_ cell: CountryTableViewCell, viewModel: CountryList) {
        cell.setUp(with: viewModel)
    }
 
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { [weak self] _ in
            self?.refreshControl.sendActions(for: .valueChanged)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
