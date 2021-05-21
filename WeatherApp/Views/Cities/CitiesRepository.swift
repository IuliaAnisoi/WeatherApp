//
//  CitiesRepository.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 14.05.2021.
//

import Foundation
import CoreLocation

class CitiesRepository {
    let apiRequest = APIRequest()
    
    func getWeatherForCurrentLocation(completion: @escaping (Result<CurrentWeather, Error>, CLLocationCoordinate2D) -> Void) {
        LocationManager.shared.getUserLocation { location in
            self.apiRequest.fetchWeatherDataByCoordinates(for: location.coordinate) { result in
                completion(result, location.coordinate)
            }
        }
    }
    
    func getWeatherForCities(coordinates: CLLocationCoordinate2D, completion:  @escaping (Result<CurrentWeather, Error>) -> Void) {
        self.apiRequest.fetchWeatherDataByCoordinates(for: coordinates) { result in
            completion(result)
        }
    }
    
}
