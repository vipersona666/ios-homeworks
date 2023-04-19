//
//  LocalNotificationsService.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 18.04.2023.
//

import Foundation
import UserNotifications
import UIKit

class LocalNotificationsService{
    
    func registeForLatestUpdatesIfPossible(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization ( options: [.sound, .badge, .provisional]) { success, error in
            if success{
                DispatchQueue.main.async {
                    let content = UNMutableNotificationContent()
                    content.title = "check_update".localized
                    content.body = "click_notification".localized
                    content.sound = .defaultRingtone
                    content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
                    var components = DateComponents()
                    components.hour = 19
                    components.minute = 00
                    components.second = 00
                    let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    center.add(request)
                }
                
            }
            if let error = error{
                print(error)
            }
        }
    }
}
