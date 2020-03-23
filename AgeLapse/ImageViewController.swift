//
//  ImageViewController.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 3/11/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var photo: Photo!
    var photoStore: PhotoStore!
    var imageStore: ImageStore!
    
    @IBAction func deleteImage(_ sender: UIBarButtonItem) {
        let title = "Delete Photo?"
        let message = "Are you sure you want to delete this photo?"
       
        let ac = UIAlertController( title: title, message: message, preferredStyle: .actionSheet )
       
        let cancelAction = UIAlertAction( title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
       
        let deleteAction = UIAlertAction( title: "Delete", style: .destructive, handler: { (action) -> Void in
            if let p = self.photo {
                self.photoStore.removePhoto(p)
                self.imageStore.deleteImage(forKey: p.photoKey)
                self.navigationController?.popViewController(animated: true)
                _ = self.photoStore.saveChanges()
            }
            
        })
        ac.addAction(deleteAction)
       
        // Present the alert Controller
        present( ac, animated: true, completion: nil )
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imageToDisplay = imageStore.image(forKey: photo.photoKey) {
            print("in imageViewController, imageToDisplay: \(imageToDisplay)")
            self.imageView.image = imageToDisplay
        }
        
    }
    
    
    
}
