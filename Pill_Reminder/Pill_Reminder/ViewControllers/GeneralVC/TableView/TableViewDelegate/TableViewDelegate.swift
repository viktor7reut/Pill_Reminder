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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = pillsToTakeAll[indexPath.row]
        let vc = PillsDetailFactory.create(pill: item)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
