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
            return pillsToTakeOneDay.count + pillsToTakeTwoDay.count + pillsToTakeThreeDay.count
        case 1:
            return pillsToTakeTwoDay.count + pillsToTakeThreeDay.count
        case 2:
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
        
        switch indexPath.section {
        case 0:
            let allPillsForSection = pillsToTakeOneDay + pillsToTakeTwoDay + pillsToTakeThreeDay
            pillCell = allPillsForSection[indexPath.row]
        case 1:
            let allPillsForSection = pillsToTakeTwoDay + pillsToTakeThreeDay
            pillCell = allPillsForSection[indexPath.row]
        case 2:
            pillCell = pillsToTakeThreeDay[indexPath.row]
        default:
            fatalError("Неожиданная секция")
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
