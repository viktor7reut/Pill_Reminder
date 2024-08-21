//
//  GeneralTableViewCell.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 23.05.24.
//

import UIKit

protocol GeneralTableViewCellDelegate: AnyObject {
    func updatePill(for index: IndexPath?)
}

class GeneralTableViewCell: UITableViewCell {
    @IBOutlet weak var pillImageView: UIImageView!
    @IBOutlet weak var namePillCell: UILabel!
    @IBOutlet weak var descriptionPillCell: UILabel!
    
    var index: IndexPath?
    weak var delegate: GeneralTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // функция обновляющая ячейку
    override func prepareForReuse() {
        super.prepareForReuse()
        setupUI()
    }
    
    func updateCell(pill: PillModel) {
        pillImageView.image = UIImage(named: "\(pill.imagePill)")
        namePillCell.text = pill.namePill
        descriptionPillCell.text = "Take \(pill.dosagePill) mg of \(pill.namePill) \(pill.frequencyPill) times a day for \(pill.intakeDuration) days."
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        self.addGestureRecognizer(longPressGesture)
        
        if pill.isCompleted {
            layer.borderColor = UIColor.green.cgColor
        } else {
            layer.borderColor = UIColor.red.cgColor
        }
        layer.borderWidth = 2.0
    }
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            delegate?.updatePill(for: index)
        }
    }
    
    private func setupUI() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 50
        clipsToBounds = true
    }
}
