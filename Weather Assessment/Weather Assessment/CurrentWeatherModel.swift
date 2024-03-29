//
//  CurrentWeatherModel.swift
//  Weather Assessment
//
//  Created by Leeann Drees on 12/10/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable {
    let weather: [Weather]
    let main: MainData
}

struct Weather: Decodable {
    let description: String
}

struct MainData: Decodable {
    let temp: Double
}
