//
//  StorageManager.swift
//  MyPlaces
//
//  Created by Светлана Шардакова on 14.05.2020.
//  Copyright © 2020 Светлана Шардакова. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager{
    
    static func saveObject(_ place: Place){
        
        try! realm.write{
            realm.add(place)
            
        }
    }
    
    static func deleteOblect(_ place: Place){
        
        try! realm.write {
            realm.delete(place)
        }
    }
}
