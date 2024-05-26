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
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var dosagePill: Double = 0 {
        didSet {
            switch dosagePill {
            case 0...5:
                dosagePillTextLabel.text = "\((dosagePill * 10).rounded() / 10)"
            case 5...10000:
                dosagePillTextLabel.text = "\(dosagePill.rounded())"
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        setupTextField()
        minusButton.setupStyleButton()
        plusButton.setupStyleButton()
    }
    
    @IBAction func minusButtonDidTap(_ sender: Any) {
        if dosagePill > 0 {
            switch dosagePill {
            case 0.1..<5:
                dosagePill -= 0.1
            case 5..<15:
                dosagePill -= 0.5
            case 15..<50:
                dosagePill -= 1
            case 50..<100:
                dosagePill -= 5
            case 100..<1000:
                dosagePill -= 10
            case 1000..<10000:
                dosagePill -= 50
            default:
                break
            }
        }
    }
    
    @IBAction func plusButtonDidTap(_ sender: Any) {
        if dosagePill >= 0 {
            switch dosagePill {
            case 0..<1:
                dosagePill += 0.1
            case 1..<5:
                dosagePill += 0.5
            case 5..<15:
                dosagePill += 1
            case 15..<50:
                dosagePill += 5
            case 50..<100:
                dosagePill += 10
            case 100..<1000:
                dosagePill += 50
            case 1000..<10000:
                dosagePill += 100
            default:
                break
            }
        }
    }
}


extension AddMedicationsVC: UITextFieldDelegate {
    func setupTextField() {
        
        namePillTextField.delegate = self
        
    }
}

// повторить textField
