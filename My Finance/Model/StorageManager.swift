//
//  StorageManager.swift
//  My Finance
//
//  Created by Максим Окунеев on 1/3/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ deposit: Deposit){
        
        try! realm.write {
            realm.add(deposit)
        }
    }
    
    static func deleteObject(_ deposit: Deposit) {
        
        try! realm.write {
            realm.delete(deposit)
        }
    }
}
