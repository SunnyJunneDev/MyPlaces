//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Светлана Шардакова on 13.05.2020.
//  Copyright © 2020 Светлана Шардакова. All rights reserved.
//

import Foundation

struct Place {
    
    var name: String
    var location: String
    var type: String
    var image: String
    
    static let restaurantNames = ["Хачо и Пури", "2 Берега", "Пятерочка", "Олис суши"]
    
    static func getPlace() -> [Place] {
        
        var places = [Place]()
        
        for place in restaurantNames{
            places.append(Place(name: place, location: "Санкт-Петербург", type: "Ресторан", image: place))
        }
        return places
    }
}
