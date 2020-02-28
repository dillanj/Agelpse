//
//  Settings.swift
//  AgeLapse
//
//  Created by Dillan Johnson on 2/10/20.
//  Copyright © 2020 Dillan Johnson. All rights reserved.
//

import Foundation

enum SettingType: String {
    case remind = "remind"
    case reminderTime = "reminder time"
    case daily = "daily"
    case fps = "fps"
}

class Settings: NSObject {
    var remind: Bool!
    var reminderTime: Date!
    var daily: Bool!
    var fps: Int!
    
    init( remind: Bool!, reminderTime: Date!, daily: Bool!, fps: Int! ){
        self.remind = remind
        self.reminderTime = reminderTime
        self.daily = daily
        self.fps = fps
    }
    
    // date formatter...
    static var _dateFormatter: DateFormatter?
    
    static var dateFormatter: DateFormatter {
      if (_dateFormatter == nil) {
        _dateFormatter = DateFormatter()
        _dateFormatter!.locale = Locale(identifier: "en_US_POSIX")
        _dateFormatter!.dateFormat = "HH:mm"
      }
      return _dateFormatter!
    }
    
    static func dateFromString(dateString: String) -> Date? {
      return dateFormatter.date(from: dateString)
    }
    
    static func dateStringFromDate(date: Date) -> String {
      return dateFormatter.string(from: date)
    }
    
    func valueForSetting(type: SettingType) -> Any {
       switch type {
       case .remind: return self.remind as Any
       case .reminderTime: return self.reminderTime as Any
       case .daily: return self.daily as Any
       case .fps: return self.fps as Any
       }
     }
    
     func stringValueForSetting(type: SettingType) -> String {
       if type == .reminderTime {
         guard let date = reminderTime  else { return "-" }
         return Settings.dateStringFromDate(date: date)
       } else {
        return valueForSetting(type: type) as? String ?? "-"
        }
     }
    
     func setValue(value: Any, forSetting type: SettingType) {
       switch type {
        case .remind: if let remind = value as? Bool { self.remind = remind }
        case .reminderTime:
           if let reminderTime = value as? Date { self.reminderTime = reminderTime }
           else if let timeString = value as? String, let timeFromString = Settings.dateFromString(dateString: timeString) { self.reminderTime = timeFromString }
        case .daily:  if let daily = value as? Bool { self.daily = daily }
        case .fps: if let fps = value as? Int { self.fps = fps }
       }
     }
    
    
    
    
}// end of Settings Class
