//
//  WeatherHeaderViewController.swift
//  WeatherApp
//
//  Created by Евгений Старшов on 29.01.2022.
//

import UIKit

final class WeatherHeaderViewController: UIViewController {
    
    enum Degrees {
        case celsium
        case fahrenheit
    }
    
    // MARK: - Properties
    
    private let weatherCaretaker = WeatherCaretaker()
    
    private var degrees: Degrees = .celsium
    private var savedWeather = [Welcome]()
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(changeDegree), name: .notificationFromTButton, object: nil)
        getWeather(cityid: cityId)
    }
    
   private func getWeather(cityid: Int) {
        var url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(cityid)&units=metric&appid=5b7a9e1cab4da31edb65f3a31877ef3d")
        if degrees == .celsium {
        url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(cityid)&units=metric&appid=5b7a9e1cab4da31edb65f3a31877ef3d")
        degrees = .fahrenheit
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: url!) { (data, response, error) in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            debugPrint(json)
            DispatchQueue.main.async {
                
                do {
                    let weatherInfo = try decoder.decode(Welcome.self, from: data)
                    print("Decoding city \(weatherInfo.name)")
                    self.savedWeather.append(weatherInfo)
                    self.weatherCaretaker.save(weather: self.savedWeather)
                    let welcome = weatherInfo
                    let main = weatherInfo.main
                    let weather = weatherInfo.weather?.last
                    self.weatherDetailHeaderView.titleLabel.text = weatherInfo.name
                    self.weatherDetailHeaderView.subtitleLabel.text = "Temperature: \(Int(weatherInfo.main?.temp ?? 0)) C°\nFeels like \(Int(main?.feelsLike ?? 0)) C°"
                    self.weatherDetailHeaderView.descriptionLabel.text = "Now in \(welcome.name) \(welcome.sys?.country ?? "") is \(weather?.weatherDescription ?? "")\nWind is \(weatherInfo.wind?.speed ?? 0) ms\nWind direction \(Int(weatherInfo.wind?.deg ?? 0))° \nPressure: \(main?.pressure ?? 0)mm\nHumidity: \(main?.humidity ?? 0)% \nMin temperature: \(Int(main?.tempMin ?? 0)) C°\nMax temperature \(Int(main?.tempMax ?? 0)) C°"
                    self.weatherDetailHeaderView.imageView.image = UIImage(named: weather?.icon ?? "unknown")
                } catch {
                    print("Decoding error \(error)")
                }
            }
        }
        task.resume()
        } else {
            url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(cityid)&units=imperial&appid=5b7a9e1cab4da31edb65f3a31877ef3d")
            degrees = .celsium
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            let task = session.dataTask(with: url!) { (data, response, error) in
                guard let data = data, error == nil else { return }
                let decoder = JSONDecoder()
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                debugPrint(json)
                DispatchQueue.main.async {
                    
                    do {
                        let weatherInfo = try decoder.decode(Welcome.self, from: data)
                        print("Decoding city \(weatherInfo.name)")
                        self.savedWeather.append(weatherInfo)
                        self.weatherCaretaker.save(weather: self.savedWeather)
                        let welcome = weatherInfo
                        let main = weatherInfo.main
                        let weather = weatherInfo.weather?.last
                        self.weatherDetailHeaderView.titleLabel.text = weatherInfo.name
                        self.weatherDetailHeaderView.subtitleLabel.text = "Temperature: \(Int(weatherInfo.main?.temp ?? 0)) F°\nFeels like \(Int(main?.feelsLike ?? 0)) F°"
                        self.weatherDetailHeaderView.descriptionLabel.text = "Now in \(welcome.name) \(welcome.sys?.country ?? "") is \(weather?.weatherDescription ?? "")\nWind is \(weatherInfo.wind?.speed ?? 0) fs\nWind direction \(Int(weatherInfo.wind?.deg ?? 0))°\nPressure: \(main?.pressure ?? 0)mm\nHumidity: \(main?.humidity ?? 0)\nMin temperature: \(Int(main?.tempMin ?? 0)) F°\nMax temperature \(Int(main?.tempMax ?? 0)) F°"
                        self.weatherDetailHeaderView.imageView.image = UIImage(named: weather?.icon ?? "unknown")
                    } catch {
                        print("Decoding error \(error)")
                    }
                }
            }
            task.resume()
        }
    }
    
    @objc func changeDegree() {
        print("Changing degrees")
        getWeather(cityid: PickedCity.shared.cityId)
    }
}

extension Notification.Name {
    static let notificationFromTButton = Notification.Name(rawValue: "notificationFromTButton")
}
