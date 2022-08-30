//
//  DetailVC.swift
//  WeatherTestTask
//
//  Created by Руслан Нургалиев on 29.08.2022.
//

import UIKit
import SwiftSVG

class DetailVC: UIViewController {
    
    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempCity: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    
    var weatherModel: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    func refreshLabels() {
        
        nameCityLabel.text = weatherModel?.name
        
        let url = URL(string: "https://yastatic.net/weather/i/icons/funky/dark/\(weatherModel?.conditionCode).svg")
        
        let weatherImage = UIView(SVGURL: url!) {(image) in
            image.resizeToFit(self.viewCity.bounds)
            
        }
        
        self.viewCity.addSubview(weatherImage)
        
        conditionLabel.text = weatherModel?.conditionString
        tempCity.text = "\((weatherModel?.temperature)!)"
        pressureLabel.text = "\((weatherModel?.presureMm)!)"
        windSpeedLabel.text = "\((weatherModel?.windSpeed)!)"
        minTempLabel.text = "\((weatherModel?.tempMin)!)"
        maxTempLabel.text = "\((weatherModel?.tempMax)!)"
        
    }

}
