//
//  ListTableVC.swift
//  WeatherTestTask
//
//  Created by Руслан Нургалиев on 29.08.2022.
//

import UIKit


class ListTableVC: UITableViewController {
    
    let emptyCity = Weather()
    
    var citiesArray = [Weather]()
    let nameCitesArray = ["Москва", "Санкт-Петербург", "Пенза", "Казань", "Новосибирск", "Челябинск", "Омск", "Екатеринбург", "Томск", "Сочи"]
    
    let networkWeatherManager = NetworkWeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitesArray.count)
        }
        
        addCites()
       
    }
    
    func addCites() {
        getCityWeather(citiesArray: self.nameCitesArray) { (index, weather) in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.nameCitesArray[index]
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citiesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell

        var weather = Weather()
        
        weather = citiesArray[indexPath.row]
        
        cell.configure(weather: weather)

        return cell
    }
}
