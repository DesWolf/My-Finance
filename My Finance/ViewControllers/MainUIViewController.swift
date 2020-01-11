//
//  MainUIViewController.swift
//  My Finance
//
//  Created by Максим Окунеев on 1/6/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit
import RealmSwift

class MainUIViewController: UIViewController{

    @IBOutlet var totalSumDescription: UILabel!
    @IBOutlet var totalSumLabel: UILabel!
    @IBOutlet var currencySegment: UISegmentedControl!
    
    @IBOutlet var backgroundTotalSum: UILabel!
    
    var usd = 0.0
    var eur = 0.0
    var clickButton = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavigationController()
        
        totalSumDescription.isEnabled = true
        totalSumLabel.isEnabled = true
        
        fetchData()
        
        totalSumLabel.text = "\(getSumFromRealm().0) ₽"
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            self.totalSumDescription.text = "\(self.displaiedSum().0)"
            self.totalSumLabel.text = "\(self.displaiedSum().1)"
        }
    
    }
    
    func setupNavigationController() {
//              navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
        UITabBar.appearance().barTintColor = UIColor.init(red: 74/256, green: 118/256, blue: 168/256, alpha: 1)
//        UITabBar.appearance().backgroundImage = UIImage()
    }

   
    
    @IBAction func totalSumButton(_ sender: Any) {

        if clickButton == 0 {
            clickButton = 1
           
        } else {
            
            clickButton = 0
       }
    }
}
extension MainUIViewController: UITextFieldDelegate {
        
    private func displaiedSum() -> (String, String) {
        
        var displaiedSum = ""
        var displaiedText = ""
        
        if  clickButton == 0 {
            displaiedText = "Cумма вкладов на текущий момент:"
            switch currencySegment.selectedSegmentIndex {
            case 0:
                displaiedSum = "\(separatedNumber(Int(getSumFromRealm().0))) ₽"
            case 1:
                displaiedSum = "\(separatedNumber(Int(getSumFromRealm().0 / usd))) $"
            case 2:
                displaiedSum = "\(separatedNumber(Int(getSumFromRealm().0 / eur))) €"
            default:
                break
            }
            
        } else {
            displaiedText = "Cумма вкладов после \(getDataOfLastDeposit()):"
            
            switch currencySegment.selectedSegmentIndex {
            case 0:
                displaiedSum = "\(separatedNumber(Int(getSumFromRealm().1))) ₽"
            case 1:
                displaiedSum = "\(separatedNumber(Int(getSumFromRealm().1 / usd))) $"
            case 2:
                displaiedSum = "\(separatedNumber(Int(getSumFromRealm().1 / eur))) €"
            default:
                break
            }
        }
       
        return (displaiedText, displaiedSum)
    }
    
    private func separatedNumber(_ number: Any) -> String {
        guard let itIsANumber = number as? NSNumber else { return "Not a number" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
    
        return formatter.string(from: itIsANumber)!
    }
        
    private func getSumFromRealm () -> (Double, Double){
        
        let deposites = realm.objects(Deposit.self)
        var i = 0
        var totalSumAtStart = 0.0
        var totalSumAtEnd = 0.0
        
        while i < deposites.count {
                  
            let deposit = deposites[i]
            
            switch deposit.currencySegment {
            case 0:
                totalSumAtStart = totalSumAtStart + deposit.sum
                totalSumAtEnd = totalSumAtEnd + deposit.finalSum
            case 1:
                totalSumAtStart = totalSumAtStart + deposit.sum * usd
                totalSumAtEnd = totalSumAtEnd + deposit.finalSum * usd
            case 2:
                totalSumAtStart = totalSumAtStart + deposit.sum * eur
                totalSumAtEnd = totalSumAtEnd + deposit.finalSum * eur
            default:
                break
            }
            i += 1
        }
        
        totalSumAtStart = Double((String(format: "%.2f", totalSumAtStart))) ?? 0.0
        totalSumAtEnd = Double((String(format: "%.2f", totalSumAtEnd))) ?? 0.0
        
        return(totalSumAtStart, totalSumAtEnd)
    }
    
    private func getDataOfLastDeposit() -> String {
        
        let deposites = realm.objects(Deposit.self)
        var i = 0
        var endDates = [Date]()
        
        while i < deposites.count {
              
        let deposit = deposites[i]
            endDates.append(deposit.endDate)
            i += 1
        }
        
        endDates.sort()
        
        return NewDepositViewController.dateToString(dateString: endDates.last)
    }

    private func fetchData() {

    let jsonURLString =  "https://www.cbr-xml-daily.ru/daily_json.js"
    
    guard let url = URL(string: jsonURLString) else { return}
        
    URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }

            do {
                let currencydata = try JSONDecoder().decode(CurrencyData.self, from: data)
                self.usd = Double(currencydata.Valute.USD.Value)
                self.eur = Double(currencydata.Valute.EUR.Value)
                
            } catch let error {
                print("Error serrialization Jason", error)
                }
        
        }.resume()
        return
   
    }
    @IBAction func currencySlider(_ sender: Any) {
    }
}




