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
    @objc dynamic var bankName = ""
    @objc dynamic var startDate = ""
    @objc dynamic var endDate = ""
    @objc dynamic var duration = ""
    @objc dynamic var percent = 0.0
    @objc dynamic var sum = 0.0
    @objc dynamic var finalSum = 0.0
    @objc dynamic var capitalisationSegment = 0
    @objc dynamic var currencySegment = 0
    
    convenience init(depositName: String, bankName: String, startDate: String, endDate: String, duration: String, percent: Double, sum: Double, finalSum: Double, capitalisationSegment: Int, currencySegment: Int) {
        self.init()
        self.depositName = depositName
        self.bankName = bankName
        self.startDate = startDate
        self.endDate = endDate
        self.duration = duration
        self.percent = percent
        self.sum = sum
        self.finalSum = finalSum
        self.capitalisationSegment = capitalisationSegment
        self.currencySegment = currencySegment
    }
}





