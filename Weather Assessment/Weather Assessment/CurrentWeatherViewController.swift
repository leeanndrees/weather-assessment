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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WeatherNetworking.shared.getCurrentWeather(latitude: 35, longitude: 139, success: { (response) in
            print("yay")
        }) { (error) in
            print("oh no")
        }
    }


}

