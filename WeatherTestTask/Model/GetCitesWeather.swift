//
//  GetCitesWeather.swift
//  WeatherTestTask
//
//  Created by Руслан Нургалиев on 29.08.2022.
//

import Foundation
import CoreLocation

let networkWeatherManager = NetworkWeatherManager()

func getCityWeather(citiesArray: [String], comletionHandler: @escaping (Int, Weather) -> ()) {
    for (index, item) in citiesArray.enumerated() {
        getCoordinateFrom(city: item) { (coordinate, error) in
            guard let coordinate = coordinate, error == nil else { return }
                networkWeatherManager.fetchWeather(lat: coordinate.latitude, lon: coordinate.longitude) { (weather) in
                    comletionHandler(index, weather)
                }
        }
        
    }
    
}

func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
    CLGeocoder().geocodeAddressString(city) { placemark, error in
        completion(placemark?.first?.location?.coordinate, error)
    }
    
}
