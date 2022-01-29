//
//  CityModel.swift
//  WeatherApp
//
//  Created by Евгений Старшов on 29.01.2022.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome

struct CityModel: Codable {
    let id: Int
    let name, state, country: String
    let coord: Coord
}


