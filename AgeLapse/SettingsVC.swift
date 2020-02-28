//
//  SettingsVC.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 2/8/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsVC: UITableViewController {
    var remindMe = false
    var daily = false
    var reminderTime: Date!
    
    
    
    @IBAction func exitView()->Void {
        print("got to exitView()")
        // check to see if the remindMe switch is on. If it is, create/update a notification
        if remindMe {
            createNotification()
            print("created Notification")
        }
        self.dismiss(animated: true, completion: nil)
     }
    
    @IBAction func remindMeToggle(_ sender: UISwitch) {
        print("toggled")
//        var indexPaths = [IndexPath]()
//        indexPaths.append(IndexPath(row: 1,section: 0))
//        indexPaths.append(IndexPath(row: 2,section: 0))
        remindMe = sender.isOn
        tableView.reloadData()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        print("sender.date: \(sender.date)")
        reminderTime = sender.date
    }
    
    @IBAction func dailyToggled(_ sender: UISwitch) {
        daily = sender.isOn
    }
    
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }

    var tableData = ["Remind Me", "Time", "Daily"]
    
    
    func createNotification(){
        
       let center = UNUserNotificationCenter.current()
       
       center.requestAuthorization(options: [.alert, .sound]) {
           (granted, error) in
           if granted {
               print("granted: yes")
           } else {
               print("granted: No")
            print("Error is: \(String(describing: error))")
           }
       }
    // 1
       let content = UNMutableNotificationContent()
       content.title = "Take Your Daily Selfie"
       content.subtitle = "quick, don't forget"
       content.body = "Selfie Time!"
       content.sound = UNNotificationSound.default
    
//        let date = Date().addingTimeInterval(20)
//        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: Date()) // default value
        if let remindTime = reminderTime {
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: remindTime)
        }
        
        let trigger = UNCalendarNotificationTrigger( dateMatching: dateComponents, repeats: daily)

       // 4
//        let uuidString = UUID().uuidString
        let identifier = "selfie"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            // check the error param and handle any errors
            if error != nil {
                print("error is: \(error)")
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
//        var cell:UITableViewCell!
        
        
        // If the switch is off there will only be 1 cell in the tableview.
        // If the switch is turned on, insert two new rows - A time picker cell (date picker) and a daily cell (switch)
        
        // The first cell will always be the remind me cell. This cell should be rendered as a switch cell.
        if (indexPath.row == 0 ){
            let cell = tableView.dequeueReusableCell(withIdentifier: "remindMeSwitchCell", for: indexPath) as! SwitchCell
            let settingLabel = tableData[indexPath.row]
            cell.textLabel?.text = settingLabel
            if ( cell.remindMeSwitch.isOn ){
                print("recognized that the REMIND ME switch is on in the settins VC.")
            }
            return cell
        }
        else if ( indexPath.row == 1 ){
            // time picker cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as! TimePickerCell
            let settingLabel = tableData[indexPath.row]
            cell.textLabel?.text = settingLabel
            return cell
        }
        else if ( indexPath.row == 2 ){
            // switch for daily reminder
            let cell = tableView.dequeueReusableCell(withIdentifier: "dailySwitchCell", for: indexPath) as! DailySwitchCell
            let settingLabel = tableData[indexPath.row]
            cell.textLabel?.text = settingLabel
            if ( cell.dailySwitch.isOn ){
                print("recognized that the DAILY switch is on in the settins VC.")
            }
            return cell
            
        }
    
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
        print("checking number of rows")
        if remindMe {
            return tableData.count
        } else {
            return 1
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // cell height for table view rows
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80.0
        // by placing an empty frame at the footer of the tableview, it will hide the empty rows
        self.tableView.tableFooterView = UIView(frame: .zero)
      }
    
  
    
}
