//
//  MainTableViewController.swift
//  My Finance
//
//  Created by Максим Окунеев on 12/15/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {

    @IBOutlet var sortButton: UIBarButtonItem!

    var notification = 0
    var period = ""
    var deposites: Results<Deposit>!
    var ascendingSorting = true

    override func viewDidLoad() {
        super.viewDidLoad()
        deposites = realm.objects(Deposit.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deposites.isEmpty ? 0 : deposites.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)  as! CustomTableViewCell
        let deposit = deposites[indexPath.row]
        var currency = ""
        
        func currencySegment(currencySegment: Int) -> String {
            switch currencySegment {
            case 0:
                currency = "₽"
            case 1:
                currency = "$"
            case 2:
                currency = "€"
            default:
                break
            }
            return currency
        }

        let myColor = UIColor.init(red: 74/256, green: 118/256, blue: 168/256, alpha: 1)

        cell.name.text = deposit.depositName
        cell.aditionalInfo.text = "\(Calculations.dateToString(dateString: deposit.startDate)) - \(Calculations.dateToString(dateString: deposit.endDate))"
        cell.sum.text = "\(deposit.sum) \(currencySegment(currencySegment: deposit.currencySegment))"
        cell.persent.text = "\(deposit.percent)% (\(deposit.finalSum))"
        cell.imageOfDeposit.layer.cornerRadius = 27
        cell.imageOfDeposit.clipsToBounds = true
        cell.imageOfFrame.layer.borderWidth = 2
        cell.imageOfFrame.layer.borderColor = myColor.cgColor
        cell.imageOfFrame.layer.cornerRadius =  30
        cell.imageOfFrame.clipsToBounds = true
        cell.imageOfDeposit.image = UIImage(named: deposit.bankName) ?? #imageLiteral(resourceName: "-=Нет в списке=-")

        return cell
}

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) ->
                            UISwipeActionsConfiguration? {
        let deposit = deposites[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
                StorageManager.deleteObject(deposit)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
                complete(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
              configuration.performsFirstActionWithFullSwipe = true

        return configuration
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let deposit = deposites[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let newDepositVC = navController.viewControllers.first as! NewDepositViewController
            newDepositVC.currentDeposit = deposit
        }
    }

    @IBAction func sortButtonPush(_ sender: Any) {
        ascendingSorting.toggle()
            if ascendingSorting {
                sortButton.image = #imageLiteral(resourceName: "sorting2")
            } else {
                sortButton.image = #imageLiteral(resourceName: "sorting1")
            }

        sorting()
    }

    private func sorting() {
        deposites = deposites.sorted(byKeyPath: "endDate", ascending: ascendingSorting)
        tableView.reloadData()
    }

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        guard let newDepositVC = segue.source as? NewDepositViewController else { return }
        newDepositVC.saveDeposit()
        tableView.reloadData()
    }
}
