//
//  RestaurantService.swift
//  Yelpy
//
//  Created by Blaine Beltran on 2/22/22.
//

import Foundation

class RestaurantService {
    static let shared = RestaurantService()
    
    func getRestaurantData(completion: @escaping ([Restaurant]) -> Void) {
        
        let apiKey = "YZSZxYVOZXaeBslpKIF97TUOW8MSDF8sJSLfRbIqea8mOeihdp9zeuP8VNhApg_Tpw9ixlOeTiQnEfwTgV5WSgWwttZw8tQZjKvDAPRPJUwJcZSypk1dbTam8mgVYnYx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        guard let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)") else {
            fatalError()
        }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        // Insert API Key to request
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        let session = URLSession(configuration: .default,
                                 delegate: nil,
                                 delegateQueue: .main)
        let task = session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print(error?.localizedDescription ?? "Got error")
                return
            }
            
            guard let data = data else {
                print("Got no data back")
                return
            }
            
            let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            let restaurantRawData = dataDictionary["businesses"] as! [[String: Any]]
            var restaurants = [Restaurant]()
            for rawData in restaurantRawData {
                let restaurant = Restaurant(name: rawData["name"] as! String,
                                            type: (rawData["categories"] as! [[String:String]])[0]["title"]!,
                                            rating: (rawData["rating"] as! NSNumber).intValue,
                                            phoneNumber: rawData["display_phone"] as! String,
                                            imageURL: rawData["image_url"] as! String)
                restaurants.append(restaurant)
            }
            completion(restaurants)
        }
        task.resume()
    }
}
