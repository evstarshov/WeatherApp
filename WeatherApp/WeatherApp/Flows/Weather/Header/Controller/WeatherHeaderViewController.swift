//
//  WeatherHeaderViewController.swift
//  WeatherApp
//
//  Created by Евгений Старшов on 29.01.2022.
//

import UIKit

final class WeatherHeaderViewController: UIViewController {
    
    // MARK: - Properties
    
    
    
    private var weatherService = WeatherService()
    
    private var weatherDetailHeaderView: WeatherHeaderView {
        return self.view as! WeatherHeaderView
    }
    
    // MARK: - Init
    
    //    init(weather: WeatherModel) {
    //        self.weather = weather
    //        super.init(nibName: nil, bundle: nil)
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
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
    
//    func showAlert(message: String) {
//        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//    }
    
    func getWeather(cityid: Int) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?id=\(cityid)&appid=5b7a9e1cab4da31edb65f3a31877ef3d")
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
                self.weatherDetailHeaderView.titleLabel.text =  weatherInfo.name
            } catch {
                print("Decoding error \(error)")
            }
            }
    }
        task.resume()
    }
    
}


