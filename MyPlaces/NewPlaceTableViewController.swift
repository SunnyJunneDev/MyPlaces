//
//  NewPlaceTableViewController.swift
//  MyPlaces
//
//  Created by Светлана Шардакова on 13.05.2020.
//  Copyright © 2020 Светлана Шардакова. All rights reserved.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {
    
    var currentPlace: Place?
    
    var imageIsChanged = false
    
    @IBOutlet var placeImage: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var placeNameTF: UITextField!
    @IBOutlet var placeLocationTF: UITextField!
    @IBOutlet var placeTypeTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        saveButton.isEnabled = false
        
        placeNameTF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        setupEditScreen()
        
        tableView.tableFooterView = UIView()
    }

//MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.row == 0{
            
            let cameraIcon = #imageLiteral(resourceName: "camera")
            let photoIcon = #imageLiteral(resourceName: "photo")
            
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "Camera", style: .default) {_ in
                self.chooseImagePickerSource(source: .camera)
            }
            
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
                
            let photo = UIAlertAction(title: "Photo", style: .default) {_ in
                self.chooseImagePickerSource(source: .photoLibrary)
            }
            
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Canel", style: .cancel)
                
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
            
        } else {
            view.endEditing(true)
        }
    }
    
    private func setupEditScreen() {
        
        setupNavigationBar()
        imageIsChanged = true
        
        if currentPlace != nil {
            guard let data = currentPlace?.imageData, let image = UIImage(data: data) else {return}
            
            placeImage.image = image
            placeImage.contentMode = .scaleAspectFill
            placeNameTF.text = currentPlace?.name
            placeLocationTF.text = currentPlace?.location
            placeTypeTF.text = currentPlace?.type
            
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentPlace?.name
        saveButton.isEnabled = true
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}


// MARK: - Text field delegate

extension NewPlaceTableViewController: UITextFieldDelegate {
    
    //hide keyboard by clicking "Done"
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //save Button disabled/enabled
    
    @objc private func textFieldChanged() {
        
        if placeNameTF.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    func savePlace(){
        
        var image: UIImage?
        
        if imageIsChanged{
            image = placeImage.image
        } else {
            image = #imageLiteral(resourceName: "imagePlaceholder")
        }
            
        let imageData = image?.pngData()
        
        let newPlace = Place(name: placeNameTF.text!,
                             location: placeLocationTF.text,
                             type: placeTypeTF.text,
                             imageData: imageData)
        
        if currentPlace != nil {
            try! realm.write {
                currentPlace?.name = newPlace.name
                currentPlace?.type = newPlace.type
                currentPlace?.location = newPlace.location
                currentPlace?.imageData = newPlace.imageData
            }
        } else {
            StorageManager.saveObject(newPlace)
        }
    }
}


//MARK: - Work with an image

extension NewPlaceTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func chooseImagePickerSource(source: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated:true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        
        imageIsChanged = true
        
        dismiss(animated: true)
    }
    
}
