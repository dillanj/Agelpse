//
//  time_picker_cell.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 2/10/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit

protocol DatePickerTableViewCellDelegate: class {
   func dateChangedForField(type: SettingType, toDate date: Date)
}

class TimePickerCell: UITableViewCell {
    
    @IBOutlet var timePicker: UIDatePicker!

    override func awakeFromNib() {
    super.awakeFromNib()
    }

    @IBAction func datePickerValueChanged(_ sender: Any) {
//        self.delegate?.dateChangedForField(type: type, toDate: timePicker.date)
        print("the timePicker is: \(timePicker.date)")
        
    }

    
}
