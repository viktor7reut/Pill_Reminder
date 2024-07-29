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
        
        var setTypes: Set<PillModel.Frequency> = .init()
        pills.map({ $0.frequencyPill }).forEach({ setTypes.insert($0) })
        
        let a = Array(setTypes)
        let result = a.sorted(by: { $0.rawValue < $1.rawValue })
        
        let sectionPills = pills.filter({ $0.frequencyPill.rawValue == result[indexPath.section].rawValue })
        guard sectionPills.count > indexPath.row else { return }
        let pillCell = sectionPills[indexPath.row]
        
        let vc = PillsDetailFactory.create(pill: pillCell)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //удаление по свайпу влево
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            // Получаем элемент для удаления
            var setTypes: Set<PillModel.Frequency> = .init()
            self.pills.map({ $0.frequencyPill }).forEach({ setTypes.insert($0) })
            
            let a = Array(setTypes)
            let result = a.sorted(by: { $0.rawValue < $1.rawValue })
            
            let sectionPills = self.pills.filter({ $0.frequencyPill.rawValue == result[indexPath.section].rawValue })
            guard sectionPills.count > indexPath.row else {
                completionHandler(false)
                return
            }
            
            let pillToDelete = sectionPills[indexPath.row]
            
            // Удаляем элемент из базы данных Realm
            if let realmPillToDelete = self.dataManager.realm.objects(RealmPillsModels.self)
                .filter("namePill == %@", pillToDelete.namePill)
                .filter("frequencyPill == %@", pillToDelete.frequencyPill.rawValue).first {
                self.dataManager.deletePill(model: realmPillToDelete)
            }
            
            // Удаляем элемент из массива pills
            if let index = self.pills.firstIndex(where: { $0 == pillToDelete }) {
                self.pills.remove(at: index)
            }
            
            // Обновляем таблицу
            self.generalTableView.beginUpdates()
            DispatchQueue.main.async {
                if !self.pills.contains(where: { $0.frequencyPill == pillToDelete.frequencyPill }) {
                    tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
                } else {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                
                self.generalTableView.endUpdates()
            }
            
            
            if self.pills.isEmpty {
                self.generalTableView.isHidden = true
            }
            
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
