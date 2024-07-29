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
        var setTypes: Set<PillModel.Frequency> = .init()
        pills.map({ $0.frequencyPill }).forEach({ setTypes.insert($0) })
        
        let a = Array(setTypes)
        let result = a.sorted(by: { $0.rawValue < $1.rawValue })
        
        return pills.filter({ $0.frequencyPill == result[section] }).count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var types: Set<PillModel.Frequency> = .init()
        pills.map({ $0.frequencyPill }).forEach({ types.insert($0) })
        
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(GeneralTableViewCell.self)", for: indexPath) as? GeneralTableViewCell else {
            return UITableViewCell()
        }
        
        var setTypes: Set<PillModel.Frequency> = .init()
        pills.map({ $0.frequencyPill }).forEach({ setTypes.insert($0) })
        
        let a = Array(setTypes)
        let result = a.sorted(by: { $0.rawValue < $1.rawValue })
        
        let sectionPills = pills.filter({ $0.frequencyPill.rawValue == result[indexPath.section].rawValue })
        
        guard sectionPills.count > indexPath.row else {
            return UITableViewCell()
        }
        
        let pillCell = sectionPills[indexPath.row]
        cell.updateCell(pill: pillCell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var setTypes: Set<PillModel.Frequency> = .init()
        pills.map({ $0.frequencyPill }).forEach({ setTypes.insert($0) })
        
        let a = Array(setTypes)
        let result = a.sorted(by: { $0.rawValue < $1.rawValue })
        return result[section].description
    }
}
