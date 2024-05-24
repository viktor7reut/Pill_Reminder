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
    var frequencyPill: Int
    var intakeDuration: Int
    var isCompleted: Bool = false
}
