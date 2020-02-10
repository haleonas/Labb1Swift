//
//  Cities.swift
//  Labb1Swift
//
//  Created by Jesper Stenlund on 2020-02-05.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import Foundation

struct Array: Codable
{
    let city_name:String
    let country_name:String
    let lat: Double
    let lon: Double
}

struct Cities : Codable
{
    
    var Array:[Array]
}
