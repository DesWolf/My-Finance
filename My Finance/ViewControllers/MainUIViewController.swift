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

    @IBOutlet var totalSumLabel: UILabel!
    
    var usdCource = 0.0
    var eurCource = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData2()
        check()
        totalSumLabel.text = "Total Sum : \(MainUIViewController.totalSumFunc())"
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.totalSumLabel.text = "Total Sum : \(MainUIViewController.totalSumFunc())"
      }
        
       
    }
        
    static func totalSumFunc () -> String {
        
        let deposites = realm.objects(Deposit.self)
        var i = 0
        var totalSum = 0.0
        
        while i < deposites.count {
                  
            let deposit = deposites[i]
            totalSum = totalSum + deposit.sum
            i += 1
        }
        return String(totalSum)
    }

  //  let userdata = ["CurrencyData": "Networking"]

    func check() {
        fetchData2()
        print("USD = \(usdCource)")
        print("EUR = \(eurCource)")
    }
    func fetchData2() {

        let jsonURLString =  "https://www.cbr-xml-daily.ru/daily_json.js"
        guard let url = URL(string: jsonURLString) else { return }

        URLSession.shared.dataTask(with: url) {(data, response, errror) in
            guard let data = data else { return }

            do{
                let currencydata = try JSONDecoder().decode(CurrencyData.self, from: data)
                 
                DispatchQueue.main.async {
                    self.usdCource = Double(currencydata.Valute.USD.Value)
                    self.eurCource = Double(currencydata.Valute.EUR.Value)
//                    print("USD = \(self.usdCource)")
//                    print("EUR = \(self.euroCource)")
                   }
            } catch let error {
                print("Error serrialization Jason", error)
                }
        }.resume()
    }
    
    func fetchData() {
            
            //let jsonURLString =  "https://swiftbook.ru//wp-content/uploads/api/api_course"
            //let jsonURLString =  "https://swiftbook.ru//wp-content/uploads/api/api_courses"
            let jsonURLString =  "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
            
            guard let url = URL(string: jsonURLString) else { return }
            
            URLSession.shared.dataTask(with: url) {(data, response, errror) in
               
                guard let data = data else { return }
            
                do{
                    let websiteDescription = try JSONDecoder().decode(WebSiteDescription.self, from: data)
                    print("\(websiteDescription.websiteName ?? "") \(websiteDescription.websiteDescription ?? "")")
                } catch let error {
                    print("Error serrialization Jason", error)
                }
        }.resume()
    }
}
