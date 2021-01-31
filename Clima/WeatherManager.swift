//
//  WeatherManager.swift
//  Clima
//
//  Created by Henit Work on 29/12/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate : WeatherViewController{
    func didupdateweather(weather: WeatherModel)
    func didFailWithError(error : Error)
}

struct WeatherManger{
    let weatherurl = "https://api.openweathermap.org/data/2.5/weather?appid=bbbe8786ce487f2d5e76f4f66095fef9&units=metric"
    
    
    var delegate:WeatherManagerDelegate?
    
    func fetchweather(cityname:String){
        let urlstring = "\(weatherurl)&q=\(cityname)"
        performrequest(urlstring: urlstring)
    }
    
    func fetchweatherco(latitude : CLLocationDegrees , lonngitude : CLLocationDegrees ){
        let urlstring = "\(weatherurl)&lat=\(latitude)&lon=\(lonngitude)"
        performrequest(urlstring: urlstring)
    }

    
    
    func performrequest(urlstring:String){
        if let url = URL.init(string: urlstring){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safedata = data{
                    if let weather  = self.parseJSON(weatherdata: safedata){
                        self.delegate?.didupdateweather(weather: weather)
                        
                    }
                    
                }
            }
            task.resume()
        }
        
    }
    func parseJSON(weatherdata: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherdata)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel.init(conditionid: id, name: name, temp: temp)
            
            return weather
            
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

    
    
    
    
    
}
