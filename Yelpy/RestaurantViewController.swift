//
//  ViewController.swift
//  Yelpy
//
//  Created by Blaine Beltran on 2/22/22.
//

import UIKit

class RestaurantViewController: UIViewController {

    @IBOutlet weak var restaurantTableView: UITableView!
    private var restaurants = [Restaurant]() {
        didSet {
            restaurantTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantTableView.dataSource = self
        restaurantTableView.delegate = self
        RestaurantService.shared.getRestaurantData { [weak self] restaurants in
            
            guard let strongSelf = self else { return }
            strongSelf.restaurants = restaurants
        }
    }
    


}

// MARK: - TableView Setup
extension RestaurantViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as? RestaurantTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: restaurants[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
}


