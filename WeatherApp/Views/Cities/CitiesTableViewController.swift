//
//  CitiesTableViewController.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 07.05.2021.
//

import UIKit
import MapKit
import RxSwift

class CitiesTableViewController: UITableViewController {
 
    private var citiesViewModel = CitiesViewModel()
    let disposeBag = DisposeBag()

    var cities: [City] = []
      
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        tableView.reloadData()
        citiesViewModel.cities.observe(on: MainScheduler.instance).subscribe { response in
            print(response.element)
            self.cities = response.element ?? []
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        citiesViewModel.getWeatherForCurrentLocation()
        
    }

    @IBAction func addNewCityAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "AddNewCity", bundle: nil)

        if let nextNavigationController = storyBoard.instantiateViewController(withIdentifier: "AddNewCity") as? UINavigationController {
            self.present(nextNavigationController, animated: true, completion: nil)
            if let viewController = nextNavigationController.viewControllers.first as? AddNewCityViewController {
                viewController.selectedCellDelegate = self
            }
        }
    }
}

extension CitiesTableViewController: AddNewCityViewControllerDelegate {
    func onCellTap(cityName: String, coordinates: CLLocationCoordinate2D?) {
        
        if let newLocation = coordinates {
            citiesViewModel.getWeatherForCities(for: newLocation, cityName: cityName)
        }
    }
}


//MARK: UITableViewDataSource

extension CitiesTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Favourite Cities"
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor(red: 0.00, green: 0.58, blue: 0.77, alpha: 1.00)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityTableViewCell
        let city = cities[indexPath.row]
        cell.backgroundColor = UIColor(red: 0.31, green: 0.76, blue: 0.97, alpha: 1.00)
        cell.update(with: city)
        
        return cell
    }
}

//MARK: UITableViewDelegate

extension CitiesTableViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            citiesViewModel.deleteRows(at: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let city = cities[indexPath.row]
        let weatherDetailsController = UIStoryboard(name: "WeatherDetails", bundle: nil).instantiateViewController(identifier: "WeatherDetails") as! WeatherDetailsTableViewController
        weatherDetailsController.title = city.name
        self.navigationController?.pushViewController(weatherDetailsController, animated: true)
        
    }
}
