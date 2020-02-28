//
//  CreateVC.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 2/27/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit

class CreateVC: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var amountLabel: UILabel!
    
    @IBOutlet var addPhotosButton: UIButton!
    
    @IBOutlet var generateButton: UIButton!
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
//        let screenSize: CGRect = UIScreen.main.bounds
//        let screenHeight = screenSize.height
//        let screenWidth = screenSize.width
        
        addPhotosButton.layer.cornerRadius = 22
        generateButton.layer.cornerRadius = 22

    }
    
    
}
