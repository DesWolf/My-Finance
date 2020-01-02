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
    @IBOutlet var persentLabel: UITextField!
    @IBOutlet var sumLabel: UITextField!
    @IBOutlet var percentCapitalizationSwitch: UISwitch!
    
    var newDeposit: Deposit?
    
    let bankNamePicker = UIPickerView()
    let datePicker = UIDatePicker()
    let durationPicker = UIPickerView()
    let duration = ["1 mounth", "3 mounths", "6 mounths", "1 year", "2 years", "3 years", "5 years"]
    let bankNames = ["Sberbank", "VTB", "Gasprom"]
   
    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.isEnabled = false
//        percentCapitalizationSwitch.addTarget(self,
//                                    action: #selector(percentCapitalizationSwitchChanged),
//                                    for: .valueChanged)
       
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
        
        persentLabel.inputAccessoryView = toolbar

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
    
    @IBAction func curencySegmControl(_ sender: Any) {
    }
    
    @IBAction func percentSwitch(_ sender: Any) {
    
    }
    
//    @objc func percentCapitalizationSwitchChanged(switchState: UISwitch) {
//       if percentCapitalizationSwitch.isOn {
//            percentCapitalization = true
//        } else {
//            percentCapitalization = false
//        }
//    }
    
    @IBAction func pushSaveButton(_ sender: Any) {
    
        if depositNameLabel.text?.isEmpty == true || sumLabel.text?.isEmpty == true {
            alertWrongData()
            print ("Error")
        } else {
            alertWrongData()
            print ("Ok")
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: Text field delegate
extension NewDepositViewController: UITextFieldDelegate {

    
    
    @objc func doneAction(){
        if startDateLabel.isEditing {
             getDateFromPicker()
        }
        view.endEditing(true)
         saveButton.isEnabled = true
    }
    
    func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        startDateLabel.text = formatter.string(from:datePicker.date)
    }

    func alertWrongData() {
        let alert = UIAlertController(title: "Error", message: """
                                                                        Please fill basic fields:
                                                                        Deposit name and Sum
                                                                        """,
                                preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: { _ in }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveNewDeposit() {
        newDeposit = Deposit(depositName: depositNameLabel.text!,
                                bankName: bankNameLabel.text,
                                startDate: startDateLabel.text,
                                duration: durationLabel.text,
                                persent: persentLabel.text,
                                sum: sumLabel.text!,
                                persentCapitalization: percentCapitalizationSwitch.isOn
                                )
    }
}

