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
    var location: CLLocation? {
        didSet {
            getWeatherForLocation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        viewModel.delegate = self
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

extension CurrentWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationToUse = locations.last else { return }
        location = locationToUse
        
        getWeatherForLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Could not get location", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func getWeatherForLocation() {
        guard let latitude = location?.coordinate.latitude, let longitude = location?.coordinate.longitude else { return }
        viewModel.getCurrentWeather(latitude: latitude, longitude: longitude)
    }
    
    fileprivate func setupLocationManager() {
        LocationManager.shared.delegate = self
        LocationManager.shared.requestWhenInUseAuthorization()
        LocationManager.shared.requestLocation()
    }
}

