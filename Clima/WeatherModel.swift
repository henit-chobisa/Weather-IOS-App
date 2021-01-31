//
//  WeatherModel.swift
//  Clima
//
//  Created by Henit Work on 30/12/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel {
    let conditionid: Int
    let name : String
    let temp : Double
    var tempreaturestring: String{
        return String(temp)
    }
    
    
    var condition: String {
        switch conditionid {
        case 200..<233:
            return "cloud.bolt"
            
        case 300..<321:
            return "cloud.drizzle"
        case 500..<531:
            return "cloud.rain"
        case 600..<622:
            return "cloud.snow"
        case 700..<781:
            return "cloud.fog"
        case 800:
            return "sun.max.fill"
        case 801..<804:
            return "cloud"
        default:
            return "cloud"
            
        }
        
     
    }
    
    

    
}

