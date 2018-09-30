//
//  CountryDetailViewController.swift
//  Countries
//
//  Created by Anastasia Loginova on 9/30/18.
//  Copyright © 2018 loginova. All rights reserved.
//

import UIKit
import RxSwift

class CountryDetailViewController: UIViewController {
    @IBOutlet weak var coutryDetailLabel: UILabel!
    
    var viewModel = CountryDetailViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = viewModel.name
        
        setupBindings()
        viewModel.fetchCountryDetails()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        coutryDetailLabel.text = "Loading"
    }

    private func setupBindings() {
        viewModel.country
            .asObservable()
            .map { $0.details }
            .bind(to: coutryDetailLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.error.asObservable()
            .skip(1)
            .bind { [weak self] (error) in
                self?.showAlert(message: error)
            }.disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { [weak self] _ in
            self?.viewModel.fetchCountryDetails()
        }))
        self.present(alert, animated: true, completion: nil)
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
