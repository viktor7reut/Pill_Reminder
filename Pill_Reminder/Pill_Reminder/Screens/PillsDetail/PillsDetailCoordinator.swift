//
//  PillsDetailCoordinator.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 29.05.24.
//

import UIKit

class PillsDetailCoordinator {
    enum Segue {
        case close
    }
    
    private weak var viewController: UIViewController?
    
    func setupVC(vc: UIViewController) {
        self.viewController = vc
    }
    
    func prepare(segue: Segue) {
        switch segue {
        case .close:
            viewController?.dismiss(animated: true)
        }
    }
}
