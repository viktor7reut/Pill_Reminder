//
//  AddMedicationsVC.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 23.05.24.
//

import UIKit

protocol AddPillVCDelegate: AnyObject {
    func addPillToList(model: [PillModel])
}

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
    
    weak var addPillDelegate: AddPillVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupAddPillButton()
        minusButton.setupStyleButton()
        plusButton.setupStyleButton()
        setupTapGesture()
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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

extension AddMedicationsVC {
    func setupAddPillButton() {
        addPillButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        if let namePill = namePillTextField.text, !namePill.isEmpty {
            let descriptionPill = descriptionPillTextField.text ?? "no description"
            let pillDosage = Double(dosagePillTextLabel.text!) ?? 0
            let pillFrequency = frequencyPillSegmentControl.selectedSegmentIndex
            let pillIntakeDuration = pillIntakeDuration(datePicker: intakeDurationPillDatePicker)
            
            var frequencies: [PillModel.Frequency] = []
            
            switch pillFrequency {
            case 0:
                frequencies = [.morning]
            case 1:
                frequencies = [.morning, .evening]
            default:
                frequencies = [.morning, .afternoon, .evening]
            }
            
            let models = frequencies.map { frequency in
                PillModel(
                    namePill: namePill,
                    descriptionPill: descriptionPill,
                    imagePill: "pill",
                    dosagePill: pillDosage,
                    frequencyPill: frequency,
                    intakeDuration: pillIntakeDuration,
                    isCompleted: false
                )
            }

            addPillDelegate?.addPillToList(model: models)
            
            for model in models {
                DataManager.shared.createPill(model: model)
            }
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    func pillIntakeDuration(datePicker: UIDatePicker) -> Int {
        let currentDate = Date()
        let selectedDate = datePicker.date
        let calendar = Calendar.current
        
        let date1 = calendar.startOfDay(for: currentDate)
        let date2 = calendar.startOfDay(for: selectedDate)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        if let days = components.day {
            return days
        }
        
        return 0
    }
}

