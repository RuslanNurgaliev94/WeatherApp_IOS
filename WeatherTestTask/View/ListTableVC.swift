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
    var filterCityArray = [Weather]()
    
    var nameCitesArray = ["Москва", "Санкт-Петербург", "Пенза", "Казань", "Новосибирск", "Челябинск", "Омск", "Екатеринбург", "Томск", "Сочи"]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitesArray.count)
        }
        addCites()
       
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    @IBAction func pressPlusButton(_ sender: Any) {
        
        alertPlusCity(name: "Город", placeholder: "Введите название города") { city in
            self.nameCitesArray.append(city)
            self.citiesArray.append(self.emptyCity)
            self.addCites()
        }
        
        
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
        if isFiltering {
            return filterCityArray.count
        }
        
        return citiesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListCell
        var weather = Weather()
        if isFiltering {
            weather = filterCityArray[indexPath.row]
        } else {
            weather = citiesArray[indexPath.row]
        }
        
        weather = citiesArray[indexPath.row]
        cell.configure(weather: weather)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, completionHandler) in
            let editingRow = self.nameCitesArray[indexPath.row]
            
            if let index = self.nameCitesArray.firstIndex(of: editingRow) {
                
                if self.isFiltering {
                    self.filterCityArray.remove(at: index)
                } else {
                    self.citiesArray.remove(at: index)
                }
                
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
                  
            if isFiltering {
                let filter = filterCityArray[indexPath.row]
                let dstVC = segue.destination as! DetailVC
                dstVC.weatherModel = filter
           
            } else {
                
                let cityWeather = citiesArray[indexPath.row]
                let dstVC = segue.destination as! DetailVC
                dstVC.weatherModel = cityWeather
            }

        }
    }
}

extension ListTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filterCityArray = citiesArray.filter {
            $0.name.contains(searchText)
        }
        tableView.reloadData()
    }
    
    
}
