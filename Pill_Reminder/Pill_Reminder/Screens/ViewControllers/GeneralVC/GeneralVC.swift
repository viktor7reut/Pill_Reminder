//
//  GeneralVC.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 23.05.24.
//

import UIKit
import RealmSwift

class GeneralVC: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var generalTableView: UITableView!
    
    let addPillButton = UIButton(type: .system)
    let dataManager = DataManager.shared
    
    var pills: [PillModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDate()
        setupAddPillButton()
        loadPills()
        
        generalTableView.dataSource = self
        generalTableView.delegate = self
    }
    
    func loadPills() {
        pills = dataManager.getAllPill()
        generalTableView.reloadData()
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
        let realm = try! Realm()
        try! realm.write {
            for pillModel in model {
                let realmPillModel = RealmPillsModels(from: pillModel)
                realm.add(realmPillModel)
            }
        }
        
        pills.append(contentsOf: model)
        self.pills = self.dataManager.getAllPill() 
        self.generalTableView.reloadData()
    }
}
