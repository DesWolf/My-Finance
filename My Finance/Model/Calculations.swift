//
//  Calculations.swift
//  My Finance
//
//  Created by Максим Окунеев on 1/5/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

//class Calculations {
//    
//    func endDate (startDate: String) -> String {
//       let date = startDate
//       let formatter = DateFormatter()
//       formatter.dateFormat = "dd.MM.yyyy"
//       let timeIsIt = formatter.date(from: date)
//       let y = timeIsIt!.addingTimeInterval(TimeInterval(durationCalculation(duration: durationLabel.text!)))
//       return formatter.string(from: y)
//    }
//    
//    func durationCalculation(duration: String) -> Double {
//        
//        return Double(duration.components(separatedBy: " ").first!) ?? 0.0
//    }
//    
//    // MARK: Final Sum Calculation
//    func finalSumCalculation(duration: Double, percent: Double, sum: Double, capitalization: Int ) -> Double {
//        
//        var finalSum = sum
//        var i = 0.0
//        let duration = Double(Int(Double(durationCalculation(duration: NewDepositViewController.durationLabel.text!)) / 30.41))
//        
//        switch capitalization {
//        case 0:
//            if duration  < 1.0 {
//                finalSum = finalSum + (finalSum * (percent / 12 / 100))
//            } else if duration > 1.0 {
//                let percentSum = (finalSum * (percent / 100)  *  duration / 12)
//                finalSum = finalSum + percentSum
//            }
//        case 1:
//           if duration < 1.0 {
//                finalSum = finalSum + (finalSum * percent  *  30.41 / 365) / 100
//                print(finalSum)
//            } else if duration > 1.0 {
//                while  i < duration  {
//                    let percentSum = (finalSum * percent  *  30.41 / 365) / 100
//                    finalSum = finalSum + percentSum
//                    i += 1
//                }
//            }
//        case 2:
//            while  i < duration / 12.0 {
//                let percentSum = (finalSum * percent ) / 100
//                finalSum = finalSum + percentSum
//                i += 1
//            }
//        default:
//            break
//        }
//        return Double(finalSum)
//    }
//}
