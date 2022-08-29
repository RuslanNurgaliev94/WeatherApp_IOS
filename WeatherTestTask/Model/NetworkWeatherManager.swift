//
//  NetworkWeatherManager.swift
//  WeatherTestTask
//
//  Created by Руслан Нургалиев on 29.08.2022.
//

import Foundation

struct NetworkWeatherManager {
    
    func fetchWeather(lat: Double, lon: Double, completionHandler: @escaping (Weather) -> ()) {
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(lon)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("\(apiKey)", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
           // print(String(data: data, encoding: .utf8)!)
            if let weather = self.parseJson(withData: data) {
               completionHandler(weather)
            }
        }
        task.resume()
    }
    func parseJson(withData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = Weather(weatherData: weatherData) else {
                return nil
            }
            return weather
        } catch let error as NSError {
            print(error.localizedDescription)
           // print(String(describing: error))
            
        }
        return nil
        
    }
    
    
}
