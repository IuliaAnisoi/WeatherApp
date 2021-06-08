//
//  WeatherDetailsTableViewController.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 10.05.2021.
//

import UIKit
import RxSwift
import CoreLocation

class WeatherDetailsTableViewController: UITableViewController {
    var viewModel: WeatherDetailsViewModel?
    private let disposeBag = DisposeBag()
    private var selectedCity: DetailsUIElement?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "sky\(arc4random_uniform(5) + 1)"))
        
        viewModel?.selectedCity.observe(on: MainScheduler.instance).subscribe({ [weak self] event in
            guard let self = self else { return }
            self.selectedCity = event.element
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        viewModel?.getCurrentDetails()
    }
 
}

// MARK: - Table view data source

extension WeatherDetailsTableViewController  {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        default: return (selectedCity?.serverResponse.daily.count ?? 1) - 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 140
        case 1:
            return 140
        default:
            return 70
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.deselectRow(at: indexPath, animated: true)
       
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "nowCell") as! NowTableViewCell
            if let currentDetails = selectedCity?.serverResponse.current {
                cell.update(with: currentDetails)
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyCell") as! HourlyTableViewCell
            if let hourlyDetails = selectedCity?.serverResponse.hourly {
                cell.update(with: hourlyDetails)
            }
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dailyCell") as! DailyTableViewCell
            if let listOfDays = selectedCity?.serverResponse.daily {
                let day = listOfDays[indexPath.row + 1]
                cell.update(with: day)
            }
            return cell
        }
    }
    
}
