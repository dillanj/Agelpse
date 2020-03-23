//
//  PhotoStore.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 2/14/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit

class PhotoStore {
    var allPhotos = [Photo]()
    
    let photoArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("photos.archive")
    }()
    
    init() {
        // check to see if there are archived photos
        if let archivedPhotos = NSKeyedUnarchiver.unarchiveObject(withFile: photoArchiveURL.path) as? [Photo]{
            allPhotos = archivedPhotos
        }
    }
    
    
    func removePhoto(_ photo: Photo ){
        if let index = allPhotos.firstIndex(of: photo){
            allPhotos.remove(at: index)
        } else {
        }
    }
    
    func saveChanges() -> Bool {
        print("saving photos to \(photoArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allPhotos, toFile: photoArchiveURL.path)
    }
}
