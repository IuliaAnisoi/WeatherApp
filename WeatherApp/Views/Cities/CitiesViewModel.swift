//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 12.05.2021.
//

import Foundation
import RxSwift
import RxCocoa

public class CitiesViewModel {
    let cities = PublishSubject<[CurrentWeather]>()
    
    
}
