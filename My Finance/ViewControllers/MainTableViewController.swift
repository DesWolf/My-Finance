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

    var deposites: Results<Deposit>!
    
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
            return (currency)
        }
        
        cell.name.text = deposit.depositName
        cell.aditionalInfo.text = "\(deposit.startDate) - \(deposit.endDate)"
        cell.sum.text = "\(deposit.sum) \(currencySegment(currencySegment: deposit.currencySegment))"
        cell.persent.text = "\(deposit.percent)% (\(deposit.finalSum))"
        
        
        //let myColor = UIColor.
        cell.imageOfDeposit.layer.cornerRadius = cell.frame.size.height / 2.45
        //cell.imageOfDeposit.layer.borderWidth = 1.5
       // cell.imageOfDeposit.layer.borderColor = myColor.cgColor
        cell.imageOfDeposit.clipsToBounds = true
        if deposit.bankName == "" {
            cell.imageOfDeposit.image = #imageLiteral(resourceName: "Safe")
        } else {
            cell.imageOfDeposit.image = UIImage(named: deposit.bankName)
        }

        return cell
}
    
    // MARK: - Table view delegate
      
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
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
    

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newDepositVC = segue.source as? NewDepositViewController else { return }
        
        newDepositVC.saveDeposit()

        tableView.reloadData()
    }
    

}
