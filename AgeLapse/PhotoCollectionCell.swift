//
//  PhotoCollectionCell.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 3/10/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var imageView: UIImageView!
    
    func update(with image: UIImage?){
        if let imageToDisplay = image {
            print("stopping Animation")
            spinner.stopAnimating()
            imageView.image = imageToDisplay
            print("imageToDisplay: \(imageToDisplay)")
            print("imageView.image: \(imageView.image)")
            
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        update(with: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(with: nil)
    }
}
