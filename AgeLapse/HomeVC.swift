//
//  ViewController.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 2/7/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit
import Photos

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
            _ = photoStore.saveChanges()
            dismiss(animated: true, completion: nil)
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//            PHPhotoLibrary.shared().performChanges({
//                var url = self.imageStore.imageURL(forKey: photo.photoKey)
//                print("url to photo is: \(url)")
//                PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
//            }) { saved, error in
//                print("got to saving")
//                if error != nil { print("error saving: \(error)")}
//                if saved {
//                    let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
//                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                    alertController.addAction(defaultAction)
//                    self.present(alertController, animated: true, completion: nil)
//                }
//            }
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         switch segue.identifier{
         case "create"?:
             let createVC = segue.destination as! CreateVC
             createVC.photoStore = photoStore
             createVC.imageStore = imageStore
            
        case "settings"?:
            let settingsVC = segue.destination as! SettingsVC

         default:
             preconditionFailure("Unexpected segue identifier")
         }// end of switch
     }//end of prepare()
    
    override func viewWillAppear(_ animated: Bool) {
        //TODO: get a nice formatted time (kind of hacking it together rn), and display the date it was taken
        super.viewWillAppear(animated)
        if let lastPhotoTaken = photoStore.allPhotos.last {
            imageView.image = imageStore.image(forKey: lastPhotoTaken.photoKey)
//            print("in homeVC imageView.image: \(imageView.image)")
            timeSinceLastPicture = ((Date().timeIntervalSince(lastPhotoTaken.fullDate) / 60) / 60)
//            print("Time since last photo: \(String(describing: timeSinceLastPicture))")
            timeSinceLastPictureLabel.text = "\(String(Int(timeSinceLastPicture))) Hours Ago"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createButton.layer.cornerRadius = 22
    }


}

