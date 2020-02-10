//
//  Extensions.swift
//  Labb1Swift
//
//  Created by Jesper Stenlund on 2020-02-10.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import Foundation

extension Double {
    var Celsius: Double {return self - 273.15}
    func truncate(places : Int)-> Double
       {
           return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
       }
}
