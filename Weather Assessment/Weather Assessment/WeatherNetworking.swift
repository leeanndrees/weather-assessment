//
//  WeatherNetworking.swift
//  Weather Assessment
//
//  Created by Leeann Drees on 12/10/19.
//  Copyright © 2019 DetroitLabs. All rights reserved.
//

import Foundation

final class WeatherNetworking {
    
    private let key = <#String#>
    private let baseURL = "https://api.openweathermap.org/data/2.5"
    
    static let shared = WeatherNetworking()
    
    public func getCurrentWeather(latitude: Int, longitude: Int, success: @escaping (CurrentWeather) -> Void, failure: @escaping (Error) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(key)"
        
        guard let url = URL(string: urlString) else { print("couldn't use url"); return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("\(error.localizedDescription)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
                
                print("error with http response");
                return }
            guard let data = data else { print("no data"); return }
            
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode(CurrentWeather.self, from: data)
                print(decoded)
                success(decoded)
            } catch {
                print("error decoding")
                failure(error)
            }
        }
        
        task.resume()
    }
    
}
