//
//  ImageStore.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 2/13/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit

class ImageStore {
    // TODO: SAVE IMAGES BY STRING(DATE) .... THAT WAY IF WE EVER TAKE A PIC WITH THE SAME DATE IT WILL JUST OVERRIDE...
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String){
        cache.setObject(image, forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        if let data = image.jpegData(compressionQuality: 0.75){
            let _ = try? data.write(to: url, options: [.atomic])
        }
    }
    
    func image(forKey key: String)-> UIImage? {
        if let existingImage = cache.object(forKey: key as NSString){
            return existingImage
        }
        
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch let deleteError {
            print("Error Removing the image from the disk: \(deleteError)")
        }
    }
    
    func imageURL(forKey key: String)-> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
}
