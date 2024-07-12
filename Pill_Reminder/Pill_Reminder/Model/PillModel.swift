//
//  PillModel.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 23.05.24.
//

import UIKit

struct PillModel {
    var namePill: String
    var descriptionPill: String
    var imagePill: String
    var dosagePill: Double
    var frequencyPill: Frequency
    var intakeDuration: Int
    var isCompleted: Bool = false
    
    enum Frequency: Int {
        case morning = 0
        case afternoon = 1
        case evening = 2
    }
}
