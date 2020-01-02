//
//  Investment Model.swift
//  My Finance
//
//  Created by Максим Окунеев on 12/16/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import UIKit

struct Deposit {
    
    var depositName: String
    var bankName: String?
    var startDate: String?
    var duration: String?
    var persent: String?
    var sum: String
    var persentCapitalization: Bool?
    
    
    static let deposits = ["Shares", "Safe", "VTB"]
    
    static func getDeposit() -> [Deposit] {
        
        var instruments = [Deposit]()
        
        for deposit in deposits {
            instruments.append(Deposit(depositName: deposit,
                                       bankName: deposit,
                                       startDate: "1.1.1",
                                       duration: "1 mounth",
                                       persent: "5",
                                       sum: "100",
                                       persentCapitalization: true
                                    ))}
        return instruments
    }
}

