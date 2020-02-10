//
//  cityData.swift
//  Labb1Swift
//
//  Created by Jesper Stenlund on 2020-02-08.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CityData
{
    var temp_max:Double = 0.0
    var temp_min:Double = 0.0
    var temp:Double = 0.0
    var wind:Int = 0
    var speed: Double = 0.0
    var feelsLike: Double = 0.0
    
    init(tempData: JSON,windData:JSON)
    {
        self.temp_max = tempData["temp_max"].double!.Celsius
        self.temp_min = tempData["temp_min"].double!.Celsius
        self.temp = tempData["temp_max"].double!.Celsius
        self.feelsLike = tempData["feels_like"].double!.Celsius
        self.wind = windData["deg"].int!
        self.speed = windData["speed"].double!
        
    }
}
