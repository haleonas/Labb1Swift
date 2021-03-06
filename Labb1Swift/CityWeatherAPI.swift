//
//  CityWeatherAPI.swift
//  Labb1Swift
//
//  Created by Jesper Stenlund on 2020-02-06.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct cityWeather
{
    let urlBase: String = "http://api.openweathermap.org/data/2.5/weather?q="//lägg till stad efter
    let apiKey: String = "&APPID=9f161223e981b6f1823a9c8364ab90e2"//lägg till efter att staden lagts till
    
    func getWeather(city:String, completion:@escaping(Result<CityData, Error>) -> Void)
    {
        //print(city)
    
        let temp = city.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
 
        let url = urlBase + temp + apiKey
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
            
                let cityData:CityData = CityData.init(tempData: json["main"], windData: json["wind"])
                completion(.success(cityData))

            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
