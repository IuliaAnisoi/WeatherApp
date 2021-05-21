//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 12.05.2021.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

public class CitiesViewModel {
    let cities = PublishSubject<[City]>()
    let citiesRepository = CitiesRepository()
    private var listOfCities: [City] = []
    
    func getWeatherForCurrentLocation() {
        citiesRepository.getWeatherForCurrentLocation { result, location in
            switch result {
            case .success(let weather):
                let weatherResponse = City(coordinates: location, name: weather.name, icon: weather.weather.first?.icon ?? "", rawTemperature: weather.main.temp)
                self.listOfCities.append(weatherResponse)
                self.cities.onNext(self.listOfCities)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getWeatherForCities(for coordinates: CLLocationCoordinate2D, cityName: String) {
        citiesRepository.getWeatherForCities(coordinates: coordinates) { result in
            switch result {
            case .success(let weatherForLocation):
                let weatherResponse = City(coordinates: coordinates, name: cityName, icon: weatherForLocation.weather.first?.icon ?? "", rawTemperature: weatherForLocation.main.temp)
                self.listOfCities.append(weatherResponse)
                self.cities.onNext(self.listOfCities)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func deleteRows(at indexPath: Int) {
        listOfCities.remove(at: indexPath)
        self.cities.onNext(self.listOfCities)

    }
}
