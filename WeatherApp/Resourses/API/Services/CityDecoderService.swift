//
//  CityDecoderService.swift
//  WeatherApp
//
//  Created by Евгений Старшов on 29.01.2022.
//

import Foundation

final class PickedCity {
    static var pickedCity: Int?
    private init(pickedCity: Int?) {
    }
}


final class CityDecoder {

    func getCities(completion: @escaping([CityModel]) -> ()) {
        let decoder = JSONDecoder()
        guard let path = Bundle.main.path(forResource: "cityList", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else { return }
        DispatchQueue.main.async {
            let cityInfo = try? decoder.decode([CityModel].self, from: data)
            let cities: [CityModel] = cityInfo!
            completion(cities)
        }
    }
}
