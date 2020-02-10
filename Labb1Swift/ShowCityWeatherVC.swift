//
//  ShowCityWeatherVC.swift
//  Labb1Swift
//
//  Created by Jesper Stenlund on 2020-02-05.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import UIKit

class ShowCityWeatherVC: UIViewController {

    var city: String = ""
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        setupApiData()
    }
    
    func setup()
    {
        cityLabel.text = city
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(imageTapped(tapGestureRecognizer:)))
        self.favoriteImageView.isUserInteractionEnabled = true
        self.favoriteImageView.addGestureRecognizer(tapGestureRecognizer)
        
        let favoriteCities = self.getFavorites()
        for city in favoriteCities
        {
            if(city == self.city)
            {
                self.favoriteImageView.image = UIImage(systemName: "star.fill")
            }
        }
    }
    
    func setupApiData()
    {
        let cityApi: cityWeather = cityWeather()
        cityApi.getWeather(city: self.city)
        {
            (result) in
            switch result
            {
            case .success(let cityData):
                print(cityData)
                
                self.tempMax.text = "\(self.tempMax.text!)\(cityData.temp_max.truncate(places: 1))°C"
                self.tempMin.text = "\(self.tempMin.text!)\(cityData.temp_min.truncate(places: 1))°C"
                self.temp.text = "\(self.temp.text!)\(cityData.temp.truncate(places: 1))°C"
                self.feelsLikeLabel.text = "\(self.feelsLikeLabel.text!)\(cityData.feelsLike.truncate(places: 1))°C"
                
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        var favoriteCities = self.getFavorites()
        
        if !favoriteCities.contains(self.city)
        {
            favoriteCities.append(self.city)
            tappedImage.image = UIImage(systemName: "star.fill")
        }
        else if favoriteCities.contains(self.city)
        {
            favoriteCities.remove(at: favoriteCities.firstIndex(of: self.city)!)
           tappedImage.image = UIImage(systemName: "star")
        }
        saveFavorite(cities: favoriteCities)
    }
    
    func saveFavorite(cities:[String])
    {
        let defaults = UserDefaults.standard
        defaults.set(cities, forKey: "favoriteCities")
        
    }
    func getFavorites() -> [String]
    {
        let defaults = UserDefaults.standard
        let favoriteCities  = defaults.object(forKey:"favoriteCities") as? [String] ?? [String]()
        
        return favoriteCities
    }
}
