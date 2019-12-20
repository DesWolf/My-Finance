//
//  MainTableViewController.swift
//  My Finance
//
//  Created by Максим Окунеев on 12/15/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    let financialInstruments = Investment.getInvestment()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return financialInstruments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)  as! CustomTableViewCell
        
        cell.name.text = financialInstruments[indexPath.row].name
        cell.aditionalInfo.text = financialInstruments[indexPath.row].aditionalInfo
        cell.sum.text = financialInstruments[indexPath.row].sum
        //cell.sum.text = financialInstruments[indexPath.row].sum
        cell.persent.text = financialInstruments[indexPath.row].persent
         cell.imageOfInstrument.image = UIImage(named: financialInstruments[indexPath.row].imageOfInstrument)
        
//        cell.imageOfInstrument.layer.cornerRadius = cell.frame.size.height / 2
//        cell.imageOfInstrument.clipsToBounds = true
//
        
        return cell
    }
    
    // MARK: - Table view delegate
      
      override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 70
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
