//
//  PhotoDataSource.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 3/2/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource {
    var photos = [Photo]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("in collectionView numberOfItems, photos count is: \(photos.count)")
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "PhotoCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as!
        PhotoCollectionViewCell
        print("in photoDataSource cell imageview: \(cell.imageView.image)")
        return cell
    }
}
