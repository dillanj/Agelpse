//
//  switch_cell.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 2/10/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {    
    @IBOutlet var remindMeSwitch: UISwitch!
    
    @IBAction func remindMeToggled(_ sender: Any) {
        if remindMeSwitch.isOn {
//            print("Toggled The switch on")
        }
        else {
//            print("Toggled The switch off")
        }
        
    }
    
    
}
