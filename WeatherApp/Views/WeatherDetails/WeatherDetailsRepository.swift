//
//  WeatherDetailsRepository.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 20.05.2021.
//

import Foundation
import CoreLocation

class WeatherDetailsRepository {
    let apiRequest = APIRequest()
    
    func getCurrentDetails(coordinates: CLLocationCoordinate2D, completion:  @escaping (Result<WeatherDetails, Error>) -> Void) {
        self.apiRequest.fetchGenericData(apiType: .details(coordinate: coordinates)) { (result: WeatherDetails) in
            completion(.success(result))
        } completionError: { (error: Error) in
            completion(.failure(error))
        }
    }
}
