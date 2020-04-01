//
//  GenerationViewController.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 3/23/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit
//import SwiftVideoGenerator

class GenerationViewController: UIViewController {
    var imageStore: ImageStore!
    var photoStore: PhotoStore!
    var image_urls = [String]()
    
    override func viewDidLoad() {
        image_urls = getAllURLs()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let timelapseBuilder = TimeLapseBuilder(photoURLs: image_urls)
//        timelapseBuilder.build({ progress in
//            print(progress)
//        }, success: { url in
//            print(url)
//        }, failure: { error in
//            print(error)
//        })
//    }
//
    func getAllURLs() -> [String] {
        var urls = [String]()
        for photo in photoStore.allPhotos {
            urls.append( imageStore.imageURL(forKey: photo.photoKey).absoluteString )
        }
        return urls
    }
    
    
    
    
    
    
}
