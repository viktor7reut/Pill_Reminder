//
//  PillModel.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 23.05.24.
//

import UIKit
import Realm

struct PillModel: Equatable {
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
        
        var description: String {
            
            switch self {
            case .morning:
                return "Утренний прием"
            case .afternoon:
                return "Обеденный прием"
            case .evening:
                return "Вечерний прием"
            }
        }
    }
    
    init(namePill: String, descriptionPill: String, imagePill: String, dosagePill: Double, frequencyPill: Frequency, intakeDuration: Int, isCompleted: Bool = false) {
            self.namePill = namePill
            self.descriptionPill = descriptionPill
            self.imagePill = imagePill
            self.dosagePill = dosagePill
            self.frequencyPill = frequencyPill
            self.intakeDuration = intakeDuration
            self.isCompleted = isCompleted
        }

    init(realmPillModel: RealmPillsModels) {
        self.namePill = realmPillModel.namePill
        self.descriptionPill = realmPillModel.descriptionPill
        self.imagePill = realmPillModel.imagePill
        self.dosagePill = realmPillModel.dosagePill
        self.frequencyPill = Frequency(rawValue: realmPillModel.frequencyPill) ?? .morning
        self.intakeDuration = realmPillModel.intakeDuration
        self.isCompleted = realmPillModel.isCompleted
    }
}
