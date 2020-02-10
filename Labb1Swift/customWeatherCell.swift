//
//  customWeatherCell.swift
//  Labb1Swift
//
//  Created by Jesper Stenlund on 2020-02-04.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import UIKit

class customWeatherCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
