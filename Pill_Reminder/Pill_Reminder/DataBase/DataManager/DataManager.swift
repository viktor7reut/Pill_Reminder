//
//  DataManager.swift
//  Pill_Reminder
//
//  Created by Виктор Реут on 15.07.24.
//

import Foundation
import RealmSwift

class DataManager {
    static let shared = DataManager()
    let realm: Realm
    
    private init() {
        realm = try! Realm()
    }
    
    func createPill(model: PillModel) {
        let newPill = RealmPillsModels(from: model)
        try! realm.write {
            realm.add(newPill)
        }
    }
    
    func getAllPill() -> [PillModel] {
        let realmPills = realm.objects(RealmPillsModels.self)
        return realmPills.map { PillModel(realmPillModel: $0) }
    }
    
    func deletePill(model: RealmPillsModels) {
        try! realm.write {
            realm.delete(model)
        }
    }
}
