//
//  HourlyTableViewCell.swift
//  WeatherApp
//
//  Created by Iulia Anisoi on 10.05.2021.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    private var hourly = [Hourly]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(with hourlyDetails: [Hourly]) {
         hourly = hourlyDetails
        collectionView.reloadData()
    }
}

extension HourlyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourly.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HourlyCollectionViewCell
        cell.configure(with: hourly[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 68, height: 115)
    }
}


