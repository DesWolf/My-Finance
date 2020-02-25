//
//  MainUIViewController.swift
//  My Finance
//
//  Created by Максим Окунеев on 1/6/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class MainUIViewController: UIViewController {

    @IBOutlet var totalSumDescription: UILabel!
    @IBOutlet var totalSumLabel: UILabel!
    @IBOutlet var currencySegment: UISegmentedControl!
    @IBOutlet var backgroundTotalSum: UILabel!

    var usd = 62.0
    var eur = 68.0
    var clickButton = 0
    var notification = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationController()

        fetchData()

        totalSumLabel.text = "\(getSumFromRealm().0) ₽"

        _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            self.totalSumDescription.text = "\(self.displaiedSum().0)"
            self.totalSumLabel.text = "\(self.displaiedSum().1)"
            self.scheduleNotification(inSeconds: 5) {(success) in
                if success {
                    print("We send it")
                } else {
                    print("Faild")
                }
            }
        }
    }

    func setupNavigationController() {
        UITabBar.appearance().barTintColor = UIColor.init(red: 74/256, green: 118/256, blue: 168/256, alpha: 1)
    }

    @IBAction func totalSumButton(_ sender: Any) {

        if clickButton == 0 {
            clickButton = 1
        } else {
            clickButton = 0
        }
    }
    func scheduleNotification(inSeconds seconds: TimeInterval, comletion: (Bool) -> Void) {

        removeNotification(withIdentifiers: ["MyUniqueIdentifier"])

        let fistEndDate = Calculations.dateFromString(getDataOfFirstAndLastDeposit().firstDate)
        var date = fistEndDate

        let content = UNMutableNotificationContent()
        content.title = "Мои Вклады"
        content.body = "Ваш вклад заканчивается завтра!"
        content.sound = UNNotificationSound.default

        let calendar = Calendar(identifier: .gregorian)

        date = calendar.date(byAdding: .hour, value: -7, to: date)!
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        let triger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "MyUniqueIdentifier", content: content, trigger: triger)

        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }

    func removeNotification(withIdentifiers identifiers: [String]) {

        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }

    deinit {
        removeNotification(withIdentifiers: ["MyUniqueIdentifier"])
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
                displaiedSum = "\(separatedNumber(Int(getSumFromRealm().totalSumAtStart))) ₽"
            case 1:
                displaiedSum = "\(separatedNumber(Int(getSumFromRealm().totalSumAtStart / usd))) $"
            case 2:
                displaiedSum = "\(separatedNumber(Int(getSumFromRealm().totalSumAtStart / eur))) €"
            default:
                break
            }

        } else {
            displaiedText = "Cумма вкладов после \(getDataOfFirstAndLastDeposit().lastDate):"

            switch currencySegment.selectedSegmentIndex {
            case 0:
                displaiedSum = "\(separatedNumber(Int(getSumFromRealm().totalSumAtEnd))) ₽"
            case 1:
                displaiedSum = "\(separatedNumber(Int(getSumFromRealm().totalSumAtEnd / usd))) $"
            case 2:
                displaiedSum = "\(separatedNumber(Int(getSumFromRealm().totalSumAtEnd / eur))) €"
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

    private func getSumFromRealm () -> (totalSumAtStart: Double, totalSumAtEnd: Double) {

        let deposites = realm.objects(Deposit.self)
        var count = 0
        var totalSumAtStart = 0.0
        var totalSumAtEnd = 0.0

        while count < deposites.count {

            let deposit = deposites[count]

            switch deposit.currencySegment {
            case 0:
                totalSumAtStart += deposit.sum
                totalSumAtEnd += deposit.finalSum
            case 1:
                totalSumAtStart += deposit.sum * usd
                totalSumAtEnd += deposit.finalSum * usd
            case 2:
                totalSumAtStart += deposit.sum * eur
                totalSumAtEnd += deposit.finalSum * eur
            default:
                break
            }
            count += 1
        }

        totalSumAtStart = Double((String(format: "%.2f", totalSumAtStart))) ?? 0.0
        totalSumAtEnd = Double((String(format: "%.2f", totalSumAtEnd))) ?? 0.0

        return(totalSumAtStart, totalSumAtEnd)
    }

    private func getDataOfFirstAndLastDeposit() -> (firstDate: String, lastDate: String) {

        let deposites = realm.objects(Deposit.self)

        var count = 0
        var depositDates = [Date]()

        while count < deposites.count {

        let deposit = deposites[count]
            depositDates.append(deposit.endDate)
            count += 1
        }
        depositDates.sort()

        let firstDate = Calculations.dateToString(dateString: depositDates.first)
        let lastDate = Calculations.dateToString(dateString: depositDates.last)
        return (firstDate, lastDate)
    }

    private func fetchData() {

        let jsonURLString = "https://www.cbr-xml-daily.ru/daily_json.js"

        guard let url = URL(string: jsonURLString) else { return}

        URLSession.shared.dataTask(with: url) { (data, _, error) in

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
}
