//
//  WeatherCareTaker.swift
//  WeatherApp
//
//  Created by Евгений Старшов on 30.01.2022.
//

import Foundation

final class WeatherCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "weather"
    
    func save(weather: [Welcome]) {
        do {
            let data = try self.encoder.encode(weather)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveWeather() -> [Welcome] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Welcome].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
