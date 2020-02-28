//
//  Photo.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 2/13/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit

class Photo: NSObject, NSCoding {
    var photoKey: String
    var fullDate: Date
    var dateTaken: String
    // dateTaken is a formatted string version of fullDate
    
    let dateFormatter:  DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    override init(){
        self.photoKey = UUID().uuidString
        self.fullDate = Date()
        self.dateTaken = dateFormatter.string(from: self.fullDate)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(photoKey, forKey: "photoKey")
        coder.encode(fullDate, forKey: "fullDate")
        coder.encode(dateTaken, forKey: "dateTaken")
    }
    
    required init(coder decoder: NSCoder){
        photoKey = decoder.decodeObject(forKey: "photoKey") as! String
        fullDate = decoder.decodeObject(forKey: "fullDate") as! Date
        dateTaken = decoder.decodeObject(forKey: "dateTaken") as! String
        super.init()
    }
    
    
}
