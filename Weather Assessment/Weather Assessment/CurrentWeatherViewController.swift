//
//  ViewController.swift
//  Weather Assessment
//
//  Created by Leeann Drees on 12/10/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import CoreLocation
import UIKit

class CurrentWeatherViewController: UIViewController {

    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    lazy var viewModel = CurrentWeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.getCurrentWeather(latitude: 35, longitude: 129)
    }
}

extension CurrentWeatherViewController: CurrentWeatherDelegate {
    func didGetWeather(temp: String, desc: String) {
        temperatureLabel.text = temp
        descriptionLabel.text = desc
    }
    
    func didFailToGetWeather(errorDescription: String) {
        let alert = UIAlertController(title: "Could not fetch weather", message: errorDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

