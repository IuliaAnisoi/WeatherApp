//
//  APIRequest.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 11.05.2021.
//

import Foundation
import CoreLocation


class APIRequest {
    
    func fetchWeatherData(for coordinates: CLLocationCoordinate2D, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        let API_KEY = "117fa230c68fd284046584083636039d"
        
        guard let urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric") else { return }
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(CurrentWeather.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    
//    func fetchWeatherDetailsData(from url: URL, completion: @escaping (Result<Weather, Error>) -> Void) {
//        var urlComponents = URLComponents(string: "api.openweathermap.org/data/2.5/onecall")!
//        urlComponents.queryItems = [
//            "api_key": "detailed_key",
//        ].map {
//            URLQueryItem(name: $0.key, value: $0.value)
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
//           // Parse the data in the response and use it
//        }
//        task.resume()
//    }

}
