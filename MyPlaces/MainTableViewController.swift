//
//  MainTableViewController.swift
//  MyPlaces
//
//  Created by Светлана Шардакова on 12.05.2020.
//  Copyright © 2020 Светлана Шардакова. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    let restaurantNames = ["Хачо и Пури", "2 Берега", "Пятерочка", "Олис суши"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.namePlace.text = restaurantNames[indexPath.row]
        cell.imageOfPlace.image = UIImage(named: restaurantNames[indexPath.row])
        //cell.imageView?.image.width = cell.frame.size.height
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace.clipsToBounds = true
        
        return cell
    }
    // MARK: - Table View delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
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
