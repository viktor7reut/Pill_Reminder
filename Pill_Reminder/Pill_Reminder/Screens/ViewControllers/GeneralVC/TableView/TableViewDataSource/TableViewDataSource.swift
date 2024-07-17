//
//  TableViewDataSource.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 23.05.24.
//

import Foundation
import UIKit

extension GeneralVC: UITableViewDataSource {
    //Количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return pills.filter({ $0.frequencyPill == .morning }).count
        case 1:
            return pills.filter({ $0.frequencyPill == .afternoon }).count
        case 2:
            return pills.filter({ $0.frequencyPill == .evening }).count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(GeneralTableViewCell.self)", for: indexPath) as? GeneralTableViewCell else {
            return UITableViewCell()
        }

        let sectionPills = pills.filter({ $0.frequencyPill.rawValue == indexPath.section })
        guard sectionPills.count > indexPath.row else {
            return UITableViewCell()
        }

        let pillCell = sectionPills[indexPath.row]
        cell.updateCell(pill: pillCell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Утренний прием"
        case 1:
            return "Обеденный прием"
        case 2:
            return "Вечерний прием"
        default:
            return nil
        }
    }
}
