//
//  Investment Model.swift
//  My Finance
//
//  Created by Максим Окунеев on 12/16/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import RealmSwift

class Deposit: Object {
    
    @objc dynamic var depositName = ""
    @objc dynamic var bankName: Data?
    @objc dynamic var startDate = ""
    @objc dynamic var duration = ""
    @objc dynamic var percent = 0.0
    @objc dynamic var sum = 0.0
    @objc dynamic var finalSum = 0.0
    @objc dynamic var persentCapitalization = ""
    
    
     let deposits = ["Shares", "Safe", "VTB"]
    
   func saveDeposit(){
    
        for deposit in deposits {
            
            let image = UIImage(named: deposit)
            guard let imageData = image?.pngData() else { return }
            
            let newDeposit = Deposit()
            
            newDeposit.depositName = deposit
            newDeposit.bankName = imageData
            newDeposit.startDate = "01.01.2000"
            newDeposit.duration = "30 days"
            newDeposit.percent = 5.0
            newDeposit.sum = 1000.0
            newDeposit.finalSum = 1100.0
            newDeposit.persentCapitalization = ""
            
            StorageManager.saveObject(newDeposit)
        
            
    }
}
}





