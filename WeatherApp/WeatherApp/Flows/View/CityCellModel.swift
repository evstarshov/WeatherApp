//
//  CityCellModel.swift
//  WeatherApp
//
//  Created by Евгений Старшов on 29.01.2022.
//

import Foundation

import Foundation

struct CityCellModel {
    let title: String
    let subtitle: String?
    let temperature: String?
}

final class CityCellModelFactory {
    
    static func cellModel(from model: CityModel) -> CityCellModel {
        return CityCellModel(title: model.name,
                             subtitle: model.state,
                             temperature: model.country)
    }
}
