//
//  WeatherData.swift
//  Clima
//
//  Created by Henit Work on 30/12/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Decodable {
    let name : String
    let main : main
    let weather : [Weather]
}

struct main: Decodable {
    let temp: Double

}
struct Weather:Decodable {
    let description: String
    let id : Int
    
}
