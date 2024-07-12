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
}
