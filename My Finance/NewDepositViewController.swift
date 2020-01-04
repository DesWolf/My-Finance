//
//  NewDepositViewController.swift
//  My Finance
//
//  Created by Максим Окунеев on 12/18/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import UIKit

class NewDepositViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var depositNameLabel: UITextField!
    @IBOutlet var bankNameLabel: UITextField!
    @IBOutlet var startDateLabel: UITextField!
    @IBOutlet var durationLabel: UITextField!
    @IBOutlet var percentLabel: UITextField!
    @IBOutlet var sumLabel: UITextField!
    @IBOutlet var persentCapitalization: UISegmentedControl!
    
   // var newDeposit = Deposit()
    
    let bankNamePicker = UIPickerView()
    let datePicker = UIDatePicker()
    let durationPicker = UIPickerView()
    let duration = ["30 days", "90 days", "180 days", "365 days", "730 days", "1095 days", "1825 days"]
    let bankNames = ["Sberbank", "VTB", "Gasprom"]
    var capitalization = ""
    var changed = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DispatchQueue.main.async {
//            self.newDeposit.saveDeposit()
//        }
        

        saveButton.isEnabled = false
        
        let textFields = [depositNameLabel, startDateLabel, durationLabel, percentLabel, sumLabel]
        for textField in textFields {
         
            textField!.addTarget(self, action: #selector(NewDepositViewController.textFieldDidChange(textField:)), for: UIControl.Event.editingDidEnd)
            
        }

        
    //MARK: Pickers
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        depositNameLabel.inputAccessoryView = toolbar
        
        bankNameLabel.inputAccessoryView = toolbar
        bankNameLabel.inputView = bankNamePicker
        bankNamePicker.delegate = self
        bankNamePicker.dataSource = self
  
        startDateLabel.inputView = datePicker
        datePicker.datePickerMode = .date
        startDateLabel.inputAccessoryView = toolbar
              
        durationLabel.inputAccessoryView = toolbar
        durationLabel.inputView = durationPicker
        durationPicker.delegate = self
        durationPicker.dataSource = self
        
        percentLabel.inputAccessoryView = toolbar

        sumLabel.inputAccessoryView = toolbar
    }
    
    
    //  BankNamePicker and DurationPicker:Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if bankNameLabel.isEditing { return bankNames.count }
        else if durationLabel.isEditing { return duration.count }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if bankNameLabel.isEditing { bankNameLabel.text = bankNames[row] }
        else if durationLabel.isEditing { durationLabel.text = duration[row] }
       }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if bankNameLabel.isEditing { return bankNames[row] }
        else if durationLabel.isEditing { return duration[row] }
        return ""
    }
    
    //MARK: Segment Countrols
    
    @IBAction func curencySegment(_ sender: Any) {
    }
    
    @IBAction func capitalizationSegment(_ sender: Any) {
         
        switch persentCapitalization.selectedSegmentIndex
            {
            case 0:
                capitalization = ""
            case 1:
                capitalization = "M"
            case 2:
                if  (durationCalculation(duration: durationLabel.text! )) < 365 {
                     alertWrongData()
                    persentCapitalization.selectedSegmentIndex = 0
                }
                capitalization = "Y"
            default:
                break
            }
        }
    
    @IBAction func pushSaveButton(_ sender: Any) {

    }

    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

    // MARK: Text field delegate
extension NewDepositViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(textField: UITextField){
        
        changed += 1
        if changed == 5 {
            saveButton.isEnabled = true
        }
        print (changed)
      }
    
    
    @objc func doneAction(){
        if startDateLabel.isEditing {
             getDateFromPicker()
        }
        view.endEditing(true)
    }
    
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        startDateLabel.text = formatter.string(from:datePicker.date)
    }

    //MARK: Alert Wrong Duration
    func alertWrongData() {
        let alert = UIAlertController(title: "Error", message: "Can't calculate. Please change Duration.", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: { _ in }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Save New Deposit
    func saveNewDeposit() {
        
        let newDeposit = Deposit()
        
        var image: UIImage?
        
        if newDeposit.bankName == nil {
            image = #imageLiteral(resourceName: "Safe")
        } else {
            image = #imageLiteral(resourceName: "Shares")
        }
        
        let imageData = image?.pngData()
        
        newDeposit.depositName = depositNameLabel.text!
        newDeposit.bankName = imageData
        newDeposit.startDate = endDate(startDate: startDateLabel.text!)
        newDeposit.duration = durationLabel.text!
        newDeposit.percent = Double(percentLabel.text!)!
        newDeposit.sum = Double(sumLabel.text!)!
        newDeposit.finalSum = finalSumCalculation(duration: durationCalculation(duration: durationLabel.text!),
                                                           percent: Double(percentLabel.text!)!,
                                                           sum: Double(sumLabel.text!)!,
                                                           capitalization: capitalization)
        newDeposit.persentCapitalization = capitalization
                            
    }
    
    func endDate (startDate: String) -> String {
        let date = startDate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        let timeIsIt = formatter.date(from: date)
        let y = timeIsIt!.addingTimeInterval(TimeInterval(durationCalculation(duration: durationLabel.text!)))
        return formatter.string(from: y)
     }
    
    func durationCalculation(duration: String) -> Double {
        
        var x = 0.0
        switch duration {
        case "30 days":
            x = 30
        case "90 days":
            x = 90
        case "180 days":
            x = 180
        case "365 days":
            x = 365
        case "730 days":
            x = 730
        case "1095 days":
            x = 1095
        case "1825 days":
            x = 1825
        default:
            break
        }
        
        return x
    }
    // MARK: Final Sum Calculation
    
    func finalSumCalculation(duration: Double, percent: Double, sum: Double, capitalization: String ) -> Double {
        
        var finalSum = sum
        var i = 0.0
        let duration = Double(Int(Double(durationCalculation(duration: durationLabel.text!)) / 30.41))
        print (duration )
        switch capitalization {
        
        case "":
          
            if duration  < 1.0 {
                finalSum = finalSum + (finalSum * (percent / 12 / 100))
            } else if duration > 1.0 {
                let percentSum = (finalSum * (percent / 100)  *  duration / 12)
                finalSum = finalSum + percentSum
            }
            print ("case -")
        
        case "M":
           if duration < 1.0 {
                finalSum = finalSum + (finalSum * percent  *  30.41 / 365) / 100
                print(finalSum)
            } else if duration > 1.0 {
                while  i < duration  {
                    let percentSum = (finalSum * percent  *  30.41 / 365) / 100
                    finalSum = finalSum + percentSum
                    i += 1
                }
            }
            print ("case M")
            
        case "Y":
            while  i < duration / 12.0 {
                let percentSum = (finalSum * percent ) / 100
                finalSum = finalSum + percentSum
                i += 1
            }
            print ("case Y")
            
        default:
            break
        }
        print(Double(finalSum))
        return Double(finalSum)
}

}
