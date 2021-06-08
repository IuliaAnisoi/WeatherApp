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
            
            self.apiRequest.fetchGenericData(apiType: .current(coordinate: location.coordinate)) { (response: CurrentWeather) in
                completion(.success(response), location.coordinate)
            } completionError: { error in
                completion(.failure(error), location.coordinate)
            }
        }
    }
    
    func getWeatherForCities(coordinates: CLLocationCoordinate2D, completion:  @escaping (Result<CurrentWeather, Error>) -> Void) {
        self.apiRequest.fetchGenericData(apiType: .current(coordinate: coordinates)) { (result: CurrentWeather) in
            completion(.success(result))
        } completionError: { (error: Error) in
            completion(.failure(error))
        }
    }
    
    func setFavouriteCities(elements: [HomeElement]) {
        UserDefaultsHelper.shared.writeData(newElements: elements)
    }
    
    func getFavouriteCities(completion: @escaping ([HomeElement]) -> Void) {
        let homeElements = UserDefaultsHelper.shared.readData()
        var currentWeatherResponses = [HomeElement]()
        let group = DispatchGroup()
        for item in homeElements  {
            group.enter()
            self.getWeatherForCities(coordinates: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)) { result in
                switch result {
                case .success(let weatherResponse):
                    currentWeatherResponses.append(HomeElement(latitude: item.latitude, longitude: item.longitude, name: item.name, icon: weatherResponse.weather.first?.icon ?? "" , rawTemperature: weatherResponse.main.temp))
                    group.leave()
                default:
                    group.leave()
                }
                
            }
        }

        group.notify(queue: .main) {
            completion(currentWeatherResponses)
        }
    }
}

