//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 20.05.2021.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class WeatherDetailsViewModel {
    let selectedCity = PublishSubject<DetailsUIElement>()
    private let weatherDetailsRepository = WeatherDetailsRepository()
    private let selectedHomeElement: HomeElement
    
    init(element: HomeElement) {
        selectedHomeElement = element
    }
    
    func getCurrentDetails() {
        weatherDetailsRepository.getCurrentDetails(coordinates: CLLocationCoordinate2D(latitude: selectedHomeElement.latitude, longitude: selectedHomeElement.longitude)) { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case .success(let weatherDetailsResponse):
                let item = DetailsUIElement(name: self.selectedHomeElement.name, serverResponse: weatherDetailsResponse)
                self.selectedCity.onNext(item)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }

}
