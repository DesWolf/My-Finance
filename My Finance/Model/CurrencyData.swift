//
//  CurrencyData.swift
//  My Finance
//
//  Created by Максим Окунеев on 1/6/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

struct CurrencyData: Decodable {
    
    let Date: String
    let PreviousDate: String
    let PreviousURL: String
    let Timestamp: String
    let Valute: Valute
  
}

struct Valute: Decodable {
    
    let USD: Currency
    let EUR: Currency

}

struct Currency: Decodable {
    
    let ID: String
    let NumCode: String
    let CharCode: String
    let Nominal: Int
    let Name: String
    let Value: Double
    let Previous: Double
}
