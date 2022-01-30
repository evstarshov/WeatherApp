//
//  WeatherHeaderViewController.swift
//  WeatherApp
//
//  Created by Евгений Старшов on 29.01.2022.
//

import UIKit

final class WeatherHeaderViewController: UIViewController {
    
    // MARK: - Properties
    
    private var weatherDetailHeaderView: WeatherHeaderView {
        return self.view as! WeatherHeaderView
    }

    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = WeatherHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cityId = PickedCity.shared.cityId
        getWeather(cityid: cityId)
    }
    
    private func getWeather(cityid: Int) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(cityid)&units=metric&appid=5b7a9e1cab4da31edb65f3a31877ef3d")
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url!) { (data, response, error) in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
            
            DispatchQueue.main.async {
                
                do {
                    let weatherInfo = try decoder.decode(Welcome.self, from: data)
                    print("Decoding city \(weatherInfo.name)")
                    let welcome = weatherInfo
                    let main = weatherInfo.main
                    let weather = weatherInfo.weather?.last
                    self.weatherDetailHeaderView.titleLabel.text = weatherInfo.name
                    self.weatherDetailHeaderView.subtitleLabel.text = "Temperature: \(Int(weatherInfo.main?.temp ?? 0)) C°"
                    self.weatherDetailHeaderView.descriptionLabel.text = "Now in \(welcome.name) \(welcome.sys?.country ?? "") is \(weather?.weatherDescription ?? "")\nWind: is \(weatherInfo.wind?.speed ?? 0) ms\nPressure: \(main?.pressure ?? 0)mm\nHumidity: \(main?.humidity ?? 0)\nMin temperature: \(Int(main?.tempMin ?? 0))\nMax temperature \(Int(main?.tempMax ?? 0))"
                } catch {
                    print("Decoding error \(error)")
                }
            }
        }
        task.resume()
    }
    
    
}


