//
//  APIRequest.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 11.05.2021.
//

import Foundation
import CoreLocation


class APIRequest {
    private let API_KEY = "117fa230c68fd284046584083636039d"
    
    func fetchWeatherDataByCoordinates(for coordinates: CLLocationCoordinate2D, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        
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
    
    func fetchWeatherDataByCityName(for cityName: String, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
    
        guard let urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather?q=Suceava&appid=\(API_KEY)&units=metric") else { return }
        
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

}
