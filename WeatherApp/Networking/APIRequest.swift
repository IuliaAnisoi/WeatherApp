//
//  APIRequest.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 11.05.2021.
//

import Foundation
import CoreLocation


class APIRequest {
    static let API_KEY = "117fa230c68fd284046584083636039d"
    static let baseUrl = "https://api.openweathermap.org/data/2.5/"
    
    func fetchGenericData<T: Decodable>(apiType: APIType, completion: @escaping (T)  -> (), completionError: @escaping (Error)  -> ()) {
        
        guard let urlComponents = URLComponents(string: apiType.url) else { return }
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!){ (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            guard let data = data else { return }
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(object)
                }
                catch let error {
                    print(error.localizedDescription)
                    completionError(error)
            }
        }
        task.resume()
    }
}

enum APIType {
    
    case current(coordinate: CLLocationCoordinate2D)
    case details(coordinate: CLLocationCoordinate2D)

    var url: String {
        switch self {
        case .current(let coordinates):
            return "\(APIRequest.baseUrl)weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(APIRequest.API_KEY)&units=metric"
        case .details(let coordinates):
        return "\(APIRequest.baseUrl)onecall?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(APIRequest.API_KEY)&units=metric"
        }
    }
}
