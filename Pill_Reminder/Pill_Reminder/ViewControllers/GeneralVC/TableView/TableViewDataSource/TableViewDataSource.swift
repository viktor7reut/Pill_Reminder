//
//  TableViewDataSource.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 23.05.24.
//

import Foundation
import UIKit

extension GeneralVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
//            return pillsToTake.filter({ $0.frequencyPill == 1 }).count
            return pillsToTakeAll.count
        case 1:
//            return pillsToTake.filter({ $0.frequencyPill == 2 }).count
            return pillsToTakeTwoAndThreeDay.count
        case 2:
//            return pillsToTake.filter({ $0.frequencyPill == 3 }).count
            return pillsToTakeThreeDay.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(GeneralTableViewCell.self)", for: indexPath) as? GeneralTableViewCell else { return UITableViewCell() }
        
        var pillCell: PillModel
        
        //проблема с фильтрацией, преппарат который применяется 2 и 3 раза в день нету в 2 и третей секции
        
        switch indexPath.section {
        case 0:
            pillCell = pillsToTakeAll[indexPath.row]
        case 1:
//            pillCell = pillsToTake.filter { $0.frequencyPill == 2 || $0.frequencyPill == 3 }[indexPath.row]
            pillCell = pillsToTakeTwoAndThreeDay[indexPath.row]
        case 2:
//            pillCell = pillsToTake.filter { $0.frequencyPill == 3 }[indexPath.row]
            pillCell = pillsToTakeThreeDay[indexPath.row]
        default:
            pillCell = PillModel(namePill: "", descriptionPill: "", imagePill: "", dosagePill: 0, frequencyPill: 0, intakeDuration: 0, isCompleted: false)
        }
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 50
        cell.clipsToBounds = true
        
        cell.updateCell(pill: pillCell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "08 - 10"
        case 1:
            return "12 - 13"
        case 2:
            return "18 - 19"
        default: 
            return nil
        }
    }
}
