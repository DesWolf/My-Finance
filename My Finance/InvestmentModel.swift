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
    
}





