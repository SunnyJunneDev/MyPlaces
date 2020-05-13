//
//  MainTableViewController.swift
//  MyPlaces
//
//  Created by Светлана Шардакова on 12.05.2020.
//  Copyright © 2020 Светлана Шардакова. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let places = Place.getPlace()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.namePlace.text = places[indexPath.row].name
        cell.imageOfPlace.image = UIImage(named: places[indexPath.row].image)
        cell.locationLabel.text = places[indexPath.row].location
        cell.typeLabel.text = places[indexPath.row].type
        cell.imageOfPlace.contentMode = .center
        cell.imageOfPlace.contentMode = .scaleToFill
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace.clipsToBounds = true
        
        return cell
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
