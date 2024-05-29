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
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = pillsToTake[indexPath.row]
        let vc = PillsDetailFactory.create(pill: item)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
