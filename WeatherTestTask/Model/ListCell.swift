//
//  ListCell.swift
//  WeatherTestTask
//
//  Created by Руслан Нургалиев on 29.08.2022.
//

import UIKit

class ListCell: UITableViewCell {

   
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var conditionCityLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    
    
    func configure(weather: Weather) {
        self.nameCityLabel.text = weather.name
        self.conditionCityLabel.text = weather.condition
        self.tempCityLabel.text = weather.temperatureString
        
    }
    
}
