//
//  TableViewDelegate.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 23.05.24.
//

import Foundation
import UIKit

extension GeneralVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    //реализация нажатия на ячейку и переход в pill
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pillsModel = pillsData[indexPath.section].value[indexPath.row]
        let vc = PillsDetailFactory.create(pill: pillsModel)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //удаление по свайпу влево
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
                        
            let model = self.pillsData[indexPath.section].value[indexPath.row]
            
            // Удаляем элемент из базы данных Realm
            self.dataManager.deletePill(model: model)
            
            // Удаляем элемент из массива pills
            self.pillsData[indexPath.section].value.remove(at: indexPath.row)
            
            // Обновляем таблицу
            self.generalTableView.beginUpdates()
            DispatchQueue.main.async {
                if self.pillsData[indexPath.section].value.isEmpty {
                    self.pillsData.remove(at: indexPath.section)
                    tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
                } else {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                
                self.generalTableView.endUpdates()
                self.generalTableView.reloadData()
            }
            if self.pillsData.isEmpty {
                self.generalTableView.isHidden = true
            }
            
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
