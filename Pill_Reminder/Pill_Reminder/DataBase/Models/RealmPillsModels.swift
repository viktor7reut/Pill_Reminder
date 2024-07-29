//
//  RealmPillsModels.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 13.07.24.
//

import Foundation
import RealmSwift

class RealmPillsModels: Object {
    @Persisted var name: String = ""
    @Persisted var namePill: String = ""
    @Persisted var descriptionPill: String = ""
    @Persisted var imagePill: String = ""
    @Persisted var dosagePill: Double = 0
    @Persisted var frequencyPill: Int = 0
    @Persisted var intakeDuration: Int = 0
    @Persisted var startDate: Date = Date()
    @Persisted var isCompleted: Bool = false
    
    convenience init(from pillModel: PillModel) {
        self.init()
        self.namePill = pillModel.namePill
        self.descriptionPill = pillModel.descriptionPill
        self.imagePill = pillModel.imagePill
        self.dosagePill = pillModel.dosagePill
        self.frequencyPill = pillModel.frequencyPill.rawValue
        self.intakeDuration = pillModel.intakeDuration
        self.startDate = pillModel.startDate
        self.isCompleted = pillModel.isCompleted
    }
}
