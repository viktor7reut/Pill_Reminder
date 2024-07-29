//
//  PillsDetailPresenter.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 29.05.24.
//

import Foundation

final class PillsDetailPresenter {
    private let model: PillsDetailModel
    private let coordinator: PillsDetailCoordinator
    
    init(model: PillsDetailModel, coordinator: PillsDetailCoordinator) {
        self.model = model
        self.coordinator = coordinator
    }
    
    func getTitle() -> String {
        return model.item.namePill
    }
    
    func getDescription() -> String {
        return "Нужно пропить \(model.item.intakeDuration) дней"
    }
    
    func getProgress() -> Float {
        let calendar = Calendar.current
        let startDate = model.item.startDate
        guard let endDate = calendar.date(byAdding: .day, value: model.item.intakeDuration, to: startDate) else {
            print("Error calculating endDate")
            return 0.0
        }
        
        let totalDuration = endDate.timeIntervalSince(startDate)
        let elapsedDuration = Date().timeIntervalSince(startDate)
        
        print("Start Date: \(startDate), End Date: \(endDate), Total Duration: \(totalDuration), Elapsed Duration: \(elapsedDuration)")
        
        if Date() >= endDate {
            return 1.0
        } else if Date() <= startDate {
            return 0.0
        } else {
            let progress = Float(elapsedDuration / totalDuration)
            print("Progress: \(progress)")
            return progress
        }
    }
}
