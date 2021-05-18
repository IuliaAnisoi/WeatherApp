//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 07.05.2021.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    private var viewModel = CitiesViewModel()

    var cities: [City]     = [
        City(name: "London", icon: " ", temperature: "22\u{00B0}C" ),
        City(name: "Prague", icon: " ", temperature: "22\u{00B0}C" ),
        City(name: "Bucharest", icon: " ", temperature: "33\u{00B0}C" ),
        City(name: "Berlin", icon: " ", temperature: "20\u{00B0}C" ),
    ]
      
    override func viewDidLoad() {
        super.viewDidLoad()
   
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        tableView.reloadData()
        viewModel.getCities()
    //    viewModel.cities.asObserver().subscribe(<#T##on: (Event<[CurrentWeather]>) -> Void##(Event<[CurrentWeather]>) -> Void#>)
        
    }

    @IBAction func addNewCityAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "AddNewCity", bundle:nil)

        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddNewCity") as? UINavigationController {
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
       return "Favourite Cities"
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! CityTableViewCell
        let city = cities[indexPath.row]
        
        cell.update(with: city)

        return cell
    }

   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
