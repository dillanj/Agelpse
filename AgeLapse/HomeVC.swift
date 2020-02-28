//
//  ViewController.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 2/7/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imageStore: ImageStore!
    var photoStore: PhotoStore!
    var photo: Photo!
    var timeSinceLastPicture: Double!
    
    let dateFormatter:  DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .long
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
   

    @IBOutlet var createButton: UIButton!
    
    //TODO: a calculated value that is the time since last photo
    @IBOutlet var timeSinceLastPictureLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        // TODO: check last picture time, see if they want to take a pic and override...
        let imagePicker = UIImagePickerController()
        
        // check for camera
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
            imagePicker.cameraDevice = .front
        } else {
            // TODO: RAISE AN ERROR AND STAY ON HOME SCREEN pg 205
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // get picked image from info dictionary
            let image = info[.originalImage] as! UIImage
        
            let photo = Photo()
            photoStore.allPhotos.append(photo)
            // store the image in the imagestore for the photos key
            imageStore.setImage(image, forKey: photo.photoKey)
            imageView.image = image
            dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //TODO: get a nice formatted time (kind of hacking it together rn), and display the date it was taken
        super.viewWillAppear(animated)
        if let lastPhotoTaken = photoStore.allPhotos.last {
            imageView.image = imageStore.image(forKey: lastPhotoTaken.photoKey)
            timeSinceLastPicture = ((Date().timeIntervalSince(lastPhotoTaken.fullDate) / 60) / 60)
            print("Time since last photo: \(String(describing: timeSinceLastPicture))")
            timeSinceLastPictureLabel.text = "\(String(Int(timeSinceLastPicture))) Hours Ago"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.layer.cornerRadius = 22
    }


}

