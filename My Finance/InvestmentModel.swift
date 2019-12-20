//
//  Investment Model.swift
//  My Finance
//
//  Created by Максим Окунеев on 12/16/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import Foundation

struct Investment {
    
    var name: String
    var aditionalInfo: String
    var sum: String
    var persent: String
    var imageOfInstrument: String
    
    static let financialInstruments = ["Shares", "Safe"]
    
    static func getInvestment() -> [Investment] {
        
        var instruments = [Investment]()
        
        for instrument in financialInstruments {
            instruments.append(Investment(name: instrument, aditionalInfo: "aditionalInfoTest", sum: "SumTest", persent: "x% Yearly", imageOfInstrument: instrument))
        }
        
        return instruments
    }
}
