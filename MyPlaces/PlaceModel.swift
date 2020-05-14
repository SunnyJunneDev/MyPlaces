//
//  PlaceModel.swift
//  MyPlaces
//

import RealmSwift

class Place: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    
    let restaurantNames = ["Хачо и Пури", "2 Берега", "Пятерочка", "Олис суши"]
    
    func savePlaces() {
        
        for place in restaurantNames {
            
            let image = UIImage(named: place)
            guard let imageData = image?.pngData() else {return}
            
            let newPlace = Place()
            newPlace.name = place
            newPlace.location = "Saint-Petersburg"
            newPlace.type = "Restaurant"
            newPlace.imageData = imageData
        }
    }
}
