//
//  RestaurantTableViewCell.swift
//  Yelpy
//
//  Created by Blaine Beltran on 2/22/22.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    @IBOutlet weak var restaurantRatingLabel: UILabel!
    @IBOutlet weak var restaurantPhoneNumberLabel: UILabel!
    
    @IBOutlet weak var restaurantImage: UIImageView!
    
    
    func configure(with restaurant: Restaurant) {
        restaurantNameLabel.text = restaurant.name
        restaurantCategoryLabel.text = restaurant.type
        restaurantRatingLabel.text = "Rating: \(restaurant.rating)"
        restaurantPhoneNumberLabel.text = restaurant.phoneNumber
    }
    
}
