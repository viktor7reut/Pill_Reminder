//
//  AddMedicationsVC.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 23.05.24.
//

import UIKit

class AddMedicationsVC: UIViewController {
    @IBOutlet weak var pillUIImageView: UIImageView!
    @IBOutlet weak var namePillTextField: UITextField!
    @IBOutlet weak var descriptionPillTextField: UITextField!
    @IBOutlet weak var dosagePillTextLabel: UILabel!
    @IBOutlet weak var frequencyPillSegmentControl: UISegmentedControl!
    @IBOutlet weak var intakeDurationPillDatePicker: UIDatePicker!
    @IBOutlet weak var addPillButton: UIButton!
    
    override func viewDidLoad() {
        setupTextField()
    }
    
}


extension AddMedicationsVC: UITextFieldDelegate {
    func setupTextField() {
        
        namePillTextField.delegate = self
        
    }
}

// повторить textField
