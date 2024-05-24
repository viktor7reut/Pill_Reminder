//
//  DateFormatter.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 23.05.24.
//

import Foundation

extension GeneralVC {
    func setupDate() {
        guard let dateLabel = dateLabel else {
            print("Error: dateLabel is nil")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        
        let currentDate = Date()
        
        let dateString = dateFormatter.string(from: currentDate)
        
        dateLabel.text = dateString
    }
}
