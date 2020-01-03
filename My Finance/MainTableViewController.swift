//
//  MainTableViewController.swift
//  My Finance
//
//  Created by Максим Окунеев on 12/15/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    var deposites = Deposit.getDeposit()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return deposites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)  as! CustomTableViewCell
        
        let deposit = deposites[indexPath.row]
        
        cell.name.text = deposit.depositName
        cell.aditionalInfo.text = "End date: \(deposit.startDate)"
        cell.sum.text = "\(deposit.sum)"
        cell.persent.text = "\(deposit.persent)% (\(deposit.finalSum))"
        if deposit.bankName == "" {
            cell.imageOfDeposit.image = #imageLiteral(resourceName: "Safe")
        } else {
            cell.imageOfDeposit.image = UIImage(named: deposit.bankName!)
        }
        
        
        
        return cell
    }
    
    // MARK: - Table view delegate
      
      override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 70
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newDepositVC = segue.source as? NewDepositViewController else { return }
        
        newDepositVC.saveNewDeposit()
        deposites.append(newDepositVC.newDeposit!)
        tableView.reloadData()
    }
    

}
