//
//  CurrentWeatherViewModel.swift
//  Weather Assessment
//
//  Created by Leeann Drees on 12/10/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

protocol CurrentWeatherDelegate: AnyObject {
    func didGetWeather(temp: String, desc: String)
    func didFailToGetWeather(errorDescription: String)
}

class CurrentWeatherViewModel {
    weak var delegate: CurrentWeatherDelegate?
    
    func getCurrentWeather(latitude: Int, longitude: Int) {
        WeatherNetworking.shared.getCurrentWeather(latitude: latitude, longitude: longitude, success: { (weather) in
            let temp = String(weather.main.temp)
            let desc = weather.weather[0].description
            self.delegate?.didGetWeather(temp: temp, desc: desc)
        }) { (error) in
            let errorString = error.localizedDescription
            self.delegate?.didFailToGetWeather(errorDescription: errorString)
        }
    }
    
}
