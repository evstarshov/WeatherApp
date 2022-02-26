//
//  CityCareTaker.swift
//  WeatherApp
//
//  Created by Евгений Старшов on 30.01.2022.
//

import Foundation


final class CityCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "cities"
    
    func save(cities: [CityModel]) {
        do {
            let data = try self.encoder.encode(cities)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveCities() -> [CityModel] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([CityModel].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
