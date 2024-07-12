//
//  GeneralVC.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 23.05.24.
//

import UIKit

class GeneralVC: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var generalTableView: UITableView!
    
    let addPillButton = UIButton(type: .system)
    
    var pills: [PillModel] = []
    
    override func viewDidLoad() {
        setupDate()
        setupAddPillButton()
        
        generalTableView.dataSource = self
    }
    
}

extension GeneralVC {
    func setupAddPillButton() {
        guard let tabBarHeight = tabBarController?.tabBar.frame.height else { return }

        addPillButton.frame = CGRect(x: view.frame.width - 80, y: view.frame.height - tabBarHeight - 88, width: 60, height: 60)
        addPillButton.setTitle("+", for: .normal)
        addPillButton.backgroundColor = UIColor.white
        addPillButton.layer.borderWidth = 1
        addPillButton.layer.cornerRadius = addPillButton.frame.width / 2
        addPillButton.layer.borderColor = UIColor.blue.cgColor
        addPillButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        view.addSubview(addPillButton)
    }
    
    @objc func buttonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "\(AddMedicationsVC.self)") as? AddMedicationsVC else { return }
        
        nextVC.addPillDelegate = self
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension GeneralVC: AddPillVCDelegate {
    func addPillToList(model: [PillModel]) {
        pills.append(contentsOf: model)
        self.generalTableView.reloadData()
    }
}
