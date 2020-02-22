//
//  FavoriteTableVC.swift
//  Labb1Swift
//
//  Created by Jesper Stenlund on 2020-02-06.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import UIKit

class FavoriteTableVC: UITableViewController {

    var favoriteCities: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoriteCities = getFavorites().sorted{$0 < $1}
        self.registerCustomTableViewCell()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteCities.count
    }

    func getFavorites() -> [String]{
           let defaults = UserDefaults.standard
           let favoriteCities  = defaults.object(forKey:"favoriteCities") as? [String] ?? [String]()
           
           return favoriteCities
       }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customWeatherCell", for: indexPath)

        if let cell = tableView.dequeueReusableCell(withIdentifier: "customWeatherCell") as? customWeatherCell {
            
            cell.cityName.text = self.favoriteCities[indexPath.row]

            return cell
        }

        return cell
    }
    
    func registerCustomTableViewCell(){
        let textFieldCell = UINib(nibName: "customWeatherCell", bundle:nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier:"customWeatherCell")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.performSegue(withIdentifier: "showCityDetailsSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow
        {
            let selectedRow = indexPath.row
            if segue.identifier == "showCityDetailsSegue"{
                let detailVC = segue.destination as! ShowCityWeatherVC
                detailVC.city = self.favoriteCities[selectedRow]
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.favoriteCities = getFavorites().sorted{$0 < $1}
        self.tableView.reloadData()
    }
}
