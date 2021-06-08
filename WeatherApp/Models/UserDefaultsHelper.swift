//
//  UserDefaultsHelper.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 08.06.2021.
//

import Foundation

class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    private let favouriteCities = "FavouriteCities"
    private let userDefaults = UserDefaults()
    
    
    func writeData(newElements: [HomeElement]) {
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(newElements)
            userDefaults.set(data, forKey: favouriteCities)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readData() -> [HomeElement] {
        if let data = userDefaults.data(forKey: favouriteCities) {
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let cities = try decoder.decode([HomeElement].self, from: data)
                return cities
            } catch  {
                print(error.localizedDescription)
                return []
            }
        }
        return []
    }
}
