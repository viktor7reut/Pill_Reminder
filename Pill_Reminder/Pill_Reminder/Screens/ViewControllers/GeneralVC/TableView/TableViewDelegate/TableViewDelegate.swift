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
        let sectionPills = pills.filter({ $0.frequencyPill.rawValue == indexPath.section })
        guard sectionPills.count > indexPath.row else { return }
        let pillCell = sectionPills[indexPath.row]
        
        let vc = PillsDetailFactory.create(pill: pillCell)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //удаление по свайпу влево
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // Получаем элемент для удаления
            let section = indexPath.section
            let sectionPills = self.pills.filter({ $0.frequencyPill.rawValue == section })
            guard sectionPills.count > indexPath.row else {
                completionHandler(false)
                return
            }
            
            let pillToDelete = sectionPills[indexPath.row]

            // Удаляем элемент из базы данных Realm
            if let realmPillToDelete = self.dataManager.realm.objects(RealmPillsModels.self).filter("namePill == %@", pillToDelete.namePill).first {
                self.dataManager.deletePill(model: realmPillToDelete)
            }

            // Удаляем элемент из массива pills
            if let index = self.pills.firstIndex(where: { $0.namePill == pillToDelete.namePill }) {
                self.pills.remove(at: index)
            }

            // Обновляем таблицу
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }, completion: { _ in
                self.pills = self.dataManager.getAllPill()
                tableView.reloadData()
            })

            completionHandler(true)
        }

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
