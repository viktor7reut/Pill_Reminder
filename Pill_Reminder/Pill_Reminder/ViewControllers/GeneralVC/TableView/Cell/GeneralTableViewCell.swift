//
//  GeneralTableViewCell.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 23.05.24.
//

import UIKit

class GeneralTableViewCell: UITableViewCell {
    @IBOutlet weak var pillImageView: UIImageView!
    @IBOutlet weak var namePillCell: UILabel!
    @IBOutlet weak var descriptionPillCell: UILabel!
    
    // функция обновляющая ячейку
    
    func updateCell(pill: PillModel) {
        pillImageView.image = UIImage(named: "\(pill.imagePill)")
        namePillCell.text = pill.namePill
        descriptionPillCell.text = "Take \(pill.dosagePill) mg of \(pill.namePill) \(pill.frequencyPill) times a day for \(pill.intakeDuration) days."
    }

}
