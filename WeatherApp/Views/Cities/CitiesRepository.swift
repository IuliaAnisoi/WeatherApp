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
    
    func getCities(completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        LocationManager.shared.getUserLocation { location in
            self.apiRequest.fetchWeatherData(for: location.coordinate) { result in
                // ce primim de pe server ca si result il transmitem inapoi folosind completion
                // completion ca si parametru este de tipul closer, la fel ca si cel de pe API
                completion(result)
            }
        }
    }
    
}
