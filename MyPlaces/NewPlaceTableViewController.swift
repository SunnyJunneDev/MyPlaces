//
//  NewPlaceTableViewController.swift
//  MyPlaces
//
//  Created by Светлана Шардакова on 13.05.2020.
//  Copyright © 2020 Светлана Шардакова. All rights reserved.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }

//MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.row == 0{
            
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) {_ in
                self.chooseImagePickerSource(source: .camera)
            }
                
            let photo = UIAlertAction(title: "Photo", style: .default) {_ in
                self.chooseImagePickerSource(source: .photoLibrary)
            }
            
            let cancel = UIAlertAction(title: "Canel", style: .cancel)
                
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
            
        } else {
            view.endEditing(true)
        }
    }
}


// MARK: - Text field delegate

extension NewPlaceTableViewController: UITextFieldDelegate {
    
    //hide keyboard by clicking "Done"
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - Work with an image

extension NewPlaceTableViewController{
    
    func chooseImagePickerSource(source: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated:true)
        }
    }
    
}
