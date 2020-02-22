//
//  WeatherTableVC.swift
//  Labb1Swift
//
//  Created by Jesper Stenlund on 2020-02-04.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import UIKit

extension WeatherTableVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText)

        searchResult = swedishCities.filter({$0.prefix(searchText.count) == searchText})
        
        searching = true
        
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searching = false
        searchBar.text = ""
        self.tableView.reloadData()
    }
}

class WeatherTableVC: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //lista med svenska städer
   var swedishCities = ["Alingsås","Åmål","Ängelholm","Arboga","Arvika","Askersund","Avesta","Boden","Bollnäs","Borgholm","Borlänge","Borås","Djursholm","Eksjö","Enköping","Eskilstuna","Eslöv","Fagersta","Falkenberg","Falköping","Falsterbo","Falun","Filipstad","Flen","Göteborg","Gränna","Gävle","Hagfors","Halmstad","Hedemora","Haparanda","Helsingborg","Hjo","Hudiksvall","Huskvarna","Härnösand","Hässleholm","Höganäs","Jönköping","Kalmar","Karlshamn","Karlskoga","Karlskrona","Karlstad","Katrineholm","Kiruna","Kramfors","Krisiantad","Kristinehamn","Kumla","Kungsbacka","Kungälv","Köping","Laholm","Landskrona","Lidingö","Lidköping","Lindesberg","Linköping","Ljungby","Ludvika","Luleå","Lund","Lycksele","Lysekil","Malmö","Mariefred","Mariestad","Marstrand","Mjölby","Motala","Nacka","Nora","Norrköping","Norrtälje","Nybro","Nyköping","Nynäshamn","Nässjö","Örebro","Öregrund","Örnsköldsvik","Oskarshamn","Östersund","Östhammar","Oxelösund","Piteå","Ronneby","Sala","Sandviken","Sigtuna","Simrishamn","Skanör","Skara","Skellefteå","Skänninge","Skövde","Sollefteå","Sollna","Stockholm","Strängnäs","Strömstad","Sundbyberg","Sundsvall","Säffle","Säter","Sävsjö","Söderhamn","Söderköping","Södertälje","Sölvesborg","Tidaholm","Torshälla","Tranås","Trelleborg","Trollhättan","Trosa","Uddevalla","Ulricehamn","Umeå","Uppsala","Vadstena","Varberg","Vaxholm","Vetlanda","Vimmerby","Visby","Vänersborg","Värnamo","Västervik","Västerås","Växjö","Ystad"]
    
    var searchResult = [String]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.swedishCities = self.swedishCities.sorted{$0 < $1}
        self.registerCustomTableViewCell()
        searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if searching{
            return searchResult.count
        } else {
            return swedishCities.count
        }
        //sektioner
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
     }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customWeatherCell", for: indexPath)
        let weatherApi = cityWeather()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customWeatherCell") as? customWeatherCell{
            if searching{
                cell.cityName.text = searchResult[indexPath.row]
                weatherApi.getWeather(city: searchResult[indexPath.row])
                {
                    (result) in
                    switch result
                    {
                    case .success(let cityData):
                        cell.temp.text = "\(cityData.temp.truncate(places: 2))"
                    case .failure(let error):
                        print(error)
                    }
                }
               
            } else {
                cell.cityName.text = swedishCities[indexPath.row]
                weatherApi.getWeather(city: swedishCities[indexPath.row])
                {
                    (result) in
                    switch result
                    {
                    case .success(let cityData):
                        cell.temp.text = "\(cityData.temp.truncate(places: 2))"
                    case .failure(let error):
                        print(error)
                    }
                }

            }
            return cell
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.performSegue(withIdentifier: "showCityDetailsSegue", sender: self)
    }
    
    func registerCustomTableViewCell(){
        let textFieldCell = UINib(nibName: "customWeatherCell", bundle:nil)
        self.tableView.register(textFieldCell, forCellReuseIdentifier:"customWeatherCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow
        {
            let selectedRow = indexPath.row
            
            if segue.identifier == "showCityDetailsSegue"{
                let detailVC = segue.destination as! ShowCityWeatherVC
                if searching{
                    detailVC.city = self.searchResult[selectedRow]
                } else {
                    detailVC.city = self.swedishCities[selectedRow]
                }
            }
        }
    }
}
