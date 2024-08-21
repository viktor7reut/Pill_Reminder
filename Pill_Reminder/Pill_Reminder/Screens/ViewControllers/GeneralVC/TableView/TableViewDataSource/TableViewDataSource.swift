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
        return pillsData[section].value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return pillsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(GeneralTableViewCell.self)", for: indexPath) as? GeneralTableViewCell else {
            return UITableViewCell()
        }
        
        let pillModel = pillsData[indexPath.section].value[indexPath.row]
        
        cell.delegate = self
        cell.index = indexPath
        
        cell.updateCell(pill: pillModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return pillsData[section].key.description
    }
}

extension GeneralVC: GeneralTableViewCellDelegate {
    
    func updatePill(for index: IndexPath?) {
        guard let indexPath = index else { return }
        
        pillsData[indexPath.section].value[indexPath.row].isCompleted.toggle()
        
        let model = self.pillsData[indexPath.section].value[indexPath.row]
        dataManager.updatePill(model: model)
        generalTableView.reloadData()
    }
}
