//
//  WeatherHeaderViewController.swift
//  WeatherApp
//
//  Created by Евгений Старшов on 29.01.2022.
//

import UIKit

final class WeatherHeaderViewController: UIViewController {
    
    // MARK: - Properties
    
    //private let city: WeatherModel
    
    private var weatherDetailHeaderView: WeatherHeaderView {
        return self.view as! WeatherHeaderView
    }
    
    // MARK: - Init
    
//    init(city: WeatherModel) {
//        self.city = city
//        super.init(nibName: nil, bundle: nil)
//    }
    
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
        
        let city = PickedCity.pickedCity
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=\(city ?? 524894)&appid=5b7a9e1cab4da31edb65f3a31877ef3d")!
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, response, error in
            let successRange = (200..<300)
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let weatherInfo = try? decoder.decode(WeatherModel.self, from: data) else { return }
                debugPrint(weatherInfo)
            
            DispatchQueue.main.async {
                self?.weatherDetailHeaderView.titleLabel.text = weatherInfo.name
            }
        }
    }
    
    }
}
