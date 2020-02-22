//
//  CompareWeatherPV.swift
//  Labb1Swift
//
//  Created by Jesper Stenlund on 2020-02-13.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import UIKit
import Charts

class CompareWeatherPV: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var pickerLeft: UIPickerView!
    @IBOutlet weak var PickerRight: UIPickerView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var chartView: BarChartView!

    let group = DispatchGroup()
    
    var chosenCity1:String?
    var chosenCity2:String?
    
    let cities = [" ","Alingsås","Åmål","Ängelholm","Arboga","Arvika","Askersund","Avesta","Boden","Bollnäs","Borgholm","Borlänge","Borås","Djursholm","Eksjö","Enköping","Eskilstuna","Eslöv","Fagersta","Falkenberg","Falköping","Falsterbo","Falun","Filipstad","Flen","Göteborg","Gränna","Gävle","Hagfors","Halmstad","Hedemora","Haparanda","Helsingborg","Hjo","Hudiksvall","Huskvarna","Härnösand","Hässleholm","Höganäs","Jönköping","Kalmar","Karlshamn","Karlskoga","Karlskrona","Karlstad","Katrineholm","Kiruna","Kramfors","Krisiantad","Kristinehamn","Kumla","Kungsbacka","Kungälv","Köping","Laholm","Landskrona","Lidingö","Lidköping","Lindesberg","Linköping","Ljungby","Ludvika","Luleå","Lund","Lycksele","Lysekil","Malmö","Mariefred","Mariestad","Marstrand","Mjölby","Motala","Nacka","Nora","Norrköping","Norrtälje","Nybro","Nyköping","Nynäshamn","Nässjö","Örebro","Öregrund","Örnsköldsvik","Oskarshamn","Östersund","Östhammar","Oxelösund","Piteå","Ronneby","Sala","Sandviken","Sigtuna","Simrishamn","Skanör","Skara","Skellefteå","Skänninge","Skövde","Sollefteå","Sollna","Stockholm","Strängnäs","Strömstad","Sundbyberg","Sundsvall","Säffle","Säter","Sävsjö","Söderhamn","Söderköping","Södertälje","Sölvesborg","Tidaholm","Torshälla","Tranås","Trelleborg","Trollhättan","Trosa","Uddevalla","Ulricehamn","Umeå","Uppsala","Vadstena","Varberg","Vaxholm","Vetlanda","Vimmerby","Visby","Vänersborg","Värnamo","Västervik","Västerås","Växjö","Ystad"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView == pickerLeft){
            self.chosenCity1 = self.cities[row]
        }
        if(pickerView == PickerRight){
            self.chosenCity2 = self.cities[row]
        }
    }
    
    @IBAction func compareWeatherPressed(_ sender: UIButton) {
        if self.chosenCity1 == nil || self.chosenCity1 == " " || self.chosenCity2 == nil || self.chosenCity2 == " " {
            self.errorLabel.text = "Nothing to compare"
        } else {
            self.errorLabel.text = "Comparing"
            let citiesToSearch = [self.chosenCity1!,self.chosenCity2!]
            var cityTemps = [Double]()
            
            self.getCitiesTemp(citiesToSearch: citiesToSearch) {
                (status) in
                print("Data retrieved")
                cityTemps.append(status)
            }
            
            let workItem = DispatchWorkItem{
                if cityTemps.count == 2 {
                    self.setChart(dataPoints: citiesToSearch, values: cityTemps)
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem)
        }
    }
    func getCitiesTemp(citiesToSearch:[String],completion:@escaping (Double) -> ())
    {
        let weatherApi = cityWeather()
       
        for city in citiesToSearch {
            weatherApi.getWeather(city: city)
            {
                (result) in
                switch result
                {
                case .success(let cityData):
                    completion(cityData.temp)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func setChart(dataPoints: [String],values: [Double]){
        var dataEntries: [BarChartDataEntry] = []
        var dataSet:[BarChartDataSet] = []
        
        self.chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:dataPoints)
        self.chartView.xAxis.granularity = 1
        
        for i in 0..<dataPoints.count{
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        for i in 0..<dataEntries.count{
            let city = BarChartDataSet(entries: dataEntries, label: dataPoints[i])
            dataSet.append(city)
        }
        
        let chartData = BarChartData(dataSets: dataSet)
       
        self.chartView.data = chartData
    }
}
