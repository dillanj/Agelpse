//
//  CreateVC.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 2/27/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit

class CreateVC: UIViewController, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var amountLabel: UILabel!
    
    @IBOutlet var addPhotosButton: UIButton!
    
    @IBOutlet var generateButton: UIButton!
    
    var photoStore: PhotoStore!
    var imageStore: ImageStore!
    let photoDataSource = PhotoDataSource()
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        let photo = photoDataSource.photos[indexPath.row]
        let image = imageStore.image(forKey: photo.photoKey)
//        print("the photo is: \(photo.photoKey)")
        let identifier = "PhotoCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier , for: indexPath) as! PhotoCollectionViewCell
        cell.update(with: image)
//        cell.imageView.image = image
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        self.photoDataSource.photos = photoStore.allPhotos
        print("when loading the createVC the photoCount is: \(photoStore.allPhotos.count)")
        self.collectionView.reloadSections(IndexSet(integer: 0))
        print("just reloaded sections")
        addPhotosButton.layer.cornerRadius = 22
        generateButton.layer.cornerRadius = 22
    }
    
    
}

//extension CreateVC {
//    override func numberOfSections(in collectionView: UICollectionView)-> Int {
//        
//    }
//}
