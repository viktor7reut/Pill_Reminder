//
//  UserNotificationCenter.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 17.07.24.
//

import UIKit
import UserNotifications

extension GeneralVC {
    
    func permissionToSendNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Разрешение на отправку уведомлений получено")
            } else {
                print("Разрешение на отправку уведомлений не получено")
            }
        }
    }
    
    func createRequest() {
        
        // Первое напоминание в 8:00
        let contentMorning = UNMutableNotificationContent()
        contentMorning.title = "Время выпить таблетки"
        contentMorning.body = "Необходимо выпить таблетки утром"
        
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        
        let triggerMorning = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let requestMorning = UNNotificationRequest(identifier: "notification1", content: contentMorning, trigger: triggerMorning)
        
        // Второе напоминание в 13:00
        let contentAfternoon = UNMutableNotificationContent()
        contentAfternoon.title = "Время выпить таблетки"
        contentAfternoon.body = "Необходимо выпить таблетки в обед"
        
        dateComponents.hour = 13
        
        let triggerAfternoon = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let requestAfternoon = UNNotificationRequest(identifier: "notification2", content: contentAfternoon, trigger: triggerAfternoon)
        
        // Третье напоминание в 18:00
        let contentEvening = UNMutableNotificationContent()
        contentEvening.title = "напоминание"
        contentEvening.body = "время выполнить задачу в 18:00!"
        
        dateComponents.hour = 18
        
        let triggerEvening = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let requestEvening = UNNotificationRequest(identifier: "notification3", content: contentEvening, trigger: triggerEvening)
        
        let center = UNUserNotificationCenter.current()
        
        center.add(requestMorning) { error in
            if error != nil {
                print("ошибка при добавлении уведомления: \\(error)")
            }
        }
        
        center.add(requestAfternoon) { error in
            if error != nil {
                print("ошибка при добавлении уведомления: \\(error)")
            }
        }
        
        center.add(requestEvening) { error in
            if error != nil {
                print("ошибка при добавлении уведомления: \\(error)")
            }
        }
    }
}
