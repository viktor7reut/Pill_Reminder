//
//  PillsDetailFactory.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 29.05.24.
//

import UIKit

class PillsDetailFactory {
    
    static func create(pill: PillModel) -> UIViewController {
        let model = PillsDetailModel(item: pill)
        let coordinator = PillsDetailCoordinator()
        let presenter = PillsDetailPresenter(model: model, coordinator: coordinator)
        let vc = PillsDetailView(presenter: presenter)
        coordinator.setupVC(vc: vc)
        
        return vc
    }
    
}
