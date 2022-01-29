//
//  WeatherSearchService.swift
//  WeatherApp
//
//  Created by Евгений Старшов on 29.01.2022.
//

import Foundation

final class WeatherService {
    
    func getWeather(cityid: Int) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(cityid)&appid=5b7a9e1cab4da31edb65f3a31877ef3d")
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url!) { (data, response, error) in
            let successRange = (200..<300)
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                    guard let weatherInfo = try? decoder.decode(Welcome.self, from: data) else { return }
                }
            }
        }
        task.resume()
    }
    

}
