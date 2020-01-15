//
//  Calculations.swift
//  My Finance
//
//  Created by Максим Окунеев on 1/5/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

class Calculations: NewDepositViewController {

    static func finalSumCalculation(duration: Double, percent: Double, sum: Double, capitalization: Int ) -> Double {
     
     var finalSum = sum
     var i = 0.0
     let duration = Double(Int(duration / 30.41))
     
     switch capitalization {
     case 0:
         if duration  < 1.0 {
             finalSum = finalSum + (finalSum * (percent / 12 / 100))
         } else if duration > 1.0 {
             let percentSum = (finalSum * (percent / 100)  *  duration / 12)
             finalSum = finalSum + percentSum
         }
     case 1:
        if duration < 1.0 {
             finalSum = finalSum + (finalSum * percent  *  30.41 / 365) / 100
             
         } else if duration > 1.0 {
             while  i < duration  {
                 let percentSum = (finalSum * percent  *  30.41 / 365) / 100
                 finalSum = finalSum + percentSum
                 i += 1
             }
         }
     case 2:
         while  i < duration / 12.0 {
             let percentSum = (finalSum * percent ) / 100
             finalSum = finalSum + percentSum
             i += 1
         }
     default:
         break
     }
     return Double((String(format: "%.2f", finalSum)))  ?? 0.0
 }
    
     static func dateFromString(_ value: String) -> Date {
         let dateFormatter = DateFormatter()
         
         dateFormatter.dateFormat = "dd.MM.yyyy"
         if let newDate = dateFormatter.date(from: value) {
             return newDate
         }
         else {
             return dateFormatter.date(from: "01.01.2200")!
         }
     }
     
     static func dateToString(dateString: Date?) -> String {
          
         var dateResult = ""
         let formatter = DateFormatter()
         formatter.dateFormat = "dd.MM.yyyy"
          
         if  dateString == nil {
             dateResult = ""
         } else {
             dateResult = formatter.string(from: dateString!)
         }
          
         return dateResult
      }
     
     static func persentFloatCheck (numberFromText: String) -> Double {
        
        var result = 0.0
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        
        if let number = formatter.number(from: numberFromText) {
            result = number.doubleValue
        }
        else{
            result = Double(numberFromText) ?? 0.0
        }
        
        return Double(result)
    }
    
}
