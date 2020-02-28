//
//  daily_switch_cell.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 2/26/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit

class DailySwitchCell: UITableViewCell {    
    @IBOutlet var dailySwitch: UISwitch!
    
    @IBAction func dailyToggled(_ sender: Any) {
        if dailySwitch.isOn {
//            print("Toggled The switch on")
        }
        else {
//            print("Toggled The switch off")
        }

    }
}
