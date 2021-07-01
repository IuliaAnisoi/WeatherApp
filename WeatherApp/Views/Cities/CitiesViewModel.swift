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
    let cities = PublishSubject<[HomeElement]>()
    let citiesRepository = CitiesRepository()
    private var listOfCities: [HomeElement] = []
    private var isCurrentLocationDisplayed = false
    
    func getWeatherForCurrentLocation() {
        citiesRepository.getWeatherForCurrentLocation { [weak self] result, location in
            guard let self = self else { return }
            switch result {
            case .success(let weather):
                
                let locationResponse = HomeElement(latitude: location.latitude, longitude: location.longitude, name: weather.name, icon: weather.weather.first?.icon ?? "", rawTemperature: weather.main.temp)
                self.listOfCities = [locationResponse] + self.listOfCities
                self.isCurrentLocationDisplayed = true
                self.cities.onNext(self.listOfCities )
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getWeatherForCities(for coordinates: CLLocationCoordinate2D, cityName: String) {
        citiesRepository.getWeatherForCities(coordinates: coordinates) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let weatherForLocation):
                
                let weatherResponse = HomeElement(latitude: coordinates.latitude, longitude: coordinates.longitude, name: cityName, icon: weatherForLocation.weather.first?.icon ?? "", rawTemperature: weatherForLocation.main.temp)
                
                self.listOfCities.append(weatherResponse)
                self.cities.onNext(self.listOfCities)
                if self.isCurrentLocationDisplayed {
                    var copyOfList = self.listOfCities
                    copyOfList.removeFirst()
                    self.citiesRepository.setFavouriteCities(elements: copyOfList)
                } else {
                    self.citiesRepository.setFavouriteCities(elements: self.listOfCities)
                }
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func deleteRows(at indexPath: Int) {
        if indexPath == 0 && isCurrentLocationDisplayed {
            return
        }
        listOfCities.remove(at: indexPath)
        self.cities.onNext(self.listOfCities)
        if self.isCurrentLocationDisplayed {
            var copyOfList = self.listOfCities
            copyOfList.removeFirst()
            self.citiesRepository.setFavouriteCities(elements: copyOfList)
        } else {
            self.citiesRepository.setFavouriteCities(elements: self.listOfCities)
        }

    }
    
    func getFavouriteCities() {
        citiesRepository.getFavouriteCities { elements in
            self.listOfCities = self.listOfCities + elements
            self.cities.onNext(self.listOfCities)
        }
    }
}
