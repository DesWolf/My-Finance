//
//  NewDepositViewController.swift
//  My Finance
//
//  Created by Максим Окунеев on 12/18/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import UIKit

class NewDepositViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var startDateLabel: UITextField!
    @IBOutlet var durationLabel: UITextField!
    @IBOutlet var persentLabel: UITextField!
    @IBOutlet var sumLabel: UITextField!
    @IBOutlet var percentCapitalizationSwitch: UISwitch!
    
    let datePicker = UIDatePicker()
    let durationPicker = UIPickerView()
    let duration = ["1 mounth", "3 mounths", "6 mounths", "1 year", "2 years", "3 years", "5 years"]
    var currentDuration = "ааа"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //StartDatePicker
        startDateLabel.inputView = datePicker
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        startDateLabel.inputAccessoryView = toolbar
        
         // DurationPicker
        durationLabel.inputAccessoryView = toolbar
        
        durationLabel.inputView = durationPicker
        durationPicker.delegate = self
        durationPicker.dataSource = self
        
         // Percent
        persentLabel.inputAccessoryView = toolbar
        
        // Sum
         sumLabel.inputAccessoryView = toolbar
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
    

    // DurationPicker:Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return duration.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           durationLabel.text = duration[row]
       }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return duration[row]
    }
    

    

    
    
    @IBAction func curencySegmControl(_ sender: Any) {
    }
    
    @IBAction func percentSwitch(_ sender: Any) {
    }
    



}

// MARK: Text field delegate
//extension NewDepositViewController: UITextFieldDelegate {
//    
//    // Скрываем клавиатуру по нажатию на Done
//    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//}
