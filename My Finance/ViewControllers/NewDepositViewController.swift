//
//  NewDepositViewController.swift
//  My Finance
//
//  Created by Максим Окунеев on 12/18/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import UIKit

class NewDepositViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var depositNameLabel: UITextField!
    @IBOutlet var bankNameLabel: UITextField!
    @IBOutlet var startDateLabel: UITextField!
    @IBOutlet var durationLabel: UITextField!
    @IBOutlet var percentLabel: UITextField!
    @IBOutlet var sumLabel: UITextField!
    @IBOutlet var capitalisationSegment: UISegmentedControl!
    @IBOutlet var currencySegment: UISegmentedControl!
    
    var currentDeposit: Deposit?
    
    let bankNamePicker = UIPickerView()
    let datePicker = UIDatePicker()
    let durationPicker = UIPickerView()
    let duration = ["30 days", "90 days", "180 days", "365 days", "730 days", "1095 days", "1825 days"]
    let bankNames = Banklist.bankNames
  
    var changed = 0
    var tableViewUpdated = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        
        let textFields = [depositNameLabel, startDateLabel, durationLabel, percentLabel, sumLabel]
        for textField in textFields {
         
            textField!.addTarget(self, action: #selector(NewDepositViewController.textFieldDidChange(textField:)), for: UIControl.Event.editingDidEnd)
        }

        setupEditScreen()
    
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
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
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
    
    // show andhide keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    //MARK: Segment Countrols
    
    @IBAction func curencySegment(_ sender: Any) {
    }
    
    @IBAction func capitalizationSegment(_ sender: Any) {
        
        switch capitalisationSegment.selectedSegmentIndex {
        case 0:
                capitalisationSegment.selectedSegmentIndex = 0
        case 1:
            if (durationCalculation(duration: durationLabel.text!) < 90.0) {
                alertWrongData()
                capitalisationSegment.selectedSegmentIndex = 0
            }
        case 2:
            if (durationCalculation(duration: durationLabel.text!) < 365.0) {
                alertWrongData()
                capitalisationSegment.selectedSegmentIndex = 0
            }
        default:
            break
        }
    }
    
    static func pushSaveButton(_ sender: Any) {

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
      }
    
    @objc func doneAction(){
        if startDateLabel.isEditing {
             getDateFromPicker()
        }
        view.endEditing(true)
    }
    
    private func getDateFromPicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        startDateLabel.text = formatter.string(from:datePicker.date)
    }

    //MARK: Alert Wrong Duration
    private func alertWrongData() {
        let alert = UIAlertController(title: "Ошибка!",
                                      message: "Невозможно рассчитать. Пожалуйста, измените длительность вклада.",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Save New Deposit
    func saveDeposit() {
        
        let newDeposit = Deposit( depositName: depositNameLabel.text!,
                                  bankName: bankNameLabel.text ?? "",
                                  startDate: NewDepositViewController.dateFromString(startDateLabel.text!),
                                  endDate: endDate(),
                                  duration: durationLabel.text!,
                                  percent: persentFloatCheck(numberFromText: percentLabel.text!),

                                  sum: Double(sumLabel.text!) ?? 0.0,
                                  finalSum: finalSumCalculation(duration: durationCalculation(duration: durationLabel.text!),
                                                                   percent: persentFloatCheck(numberFromText: percentLabel.text!),
                                                                   sum: Double(sumLabel.text!)!,
                                                                   capitalization: capitalisationSegment.selectedSegmentIndex),
                                  capitalisationSegment: capitalisationSegment.selectedSegmentIndex,
                                  currencySegment: currencySegment.selectedSegmentIndex
                                )
        if currentDeposit != nil {
        
            try! realm.write {
                currentDeposit?.depositName = newDeposit.depositName
                currentDeposit?.bankName = newDeposit.bankName
                currentDeposit?.startDate = newDeposit.startDate
                currentDeposit?.endDate = newDeposit.endDate
                currentDeposit?.duration = newDeposit.duration
                currentDeposit?.percent = newDeposit.percent
                currentDeposit?.sum = newDeposit.sum
                currentDeposit?.finalSum = newDeposit.finalSum
                currentDeposit?.capitalisationSegment = newDeposit.capitalisationSegment
                currentDeposit?.currencySegment = newDeposit.currencySegment
            }
        } else {
                StorageManager.saveObject(newDeposit)
        }
    }

    private func persentFloatCheck (numberFromText: String) -> Double {
        
        var result = 0.0
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        
        if let number = formatter.number(from: numberFromText) {
            result = number.doubleValue
        }
        else{
            result = Double(numberFromText) ?? 0.0
        }
        
        return Double(result)
    }
    
    private func setupEditScreen() {
           
        if currentDeposit != nil {
            
            setupNavigationBar()
               
            depositNameLabel.text = currentDeposit?.depositName
            bankNameLabel.text = currentDeposit?.bankName
            startDateLabel.text = NewDepositViewController.dateToString(dateString: currentDeposit?.startDate)
            durationLabel.text = currentDeposit?.duration
            percentLabel.text =  "\(currentDeposit?.percent ?? 0)"
            sumLabel.text = "\(currentDeposit?.sum ?? 0)"
            capitalisationSegment.selectedSegmentIndex = currentDeposit?.capitalisationSegment ?? 0
            currencySegment.selectedSegmentIndex = currentDeposit?.currencySegment ?? 0
           }
       }
    
    private func setupNavigationBar() {
    
        title = currentDeposit?.depositName
        saveButton.isEnabled = true
    }

    private func endDate () -> Date {
        let dateFromString = NewDepositViewController.dateFromString(startDateLabel.text!)
        let durationTime = (durationCalculation(duration: durationLabel.text!))
        let endDate = dateFromString.addingTimeInterval((durationTime) * 24 * 60 * 60)
        
        return (endDate)
     }
    
    private func durationCalculation(duration: String) -> Double {
        
        return Double(duration.components(separatedBy: " ").first!) ?? 0.0
    }
    
    // MARK: Final Sum Calculation
    private func finalSumCalculation(duration: Double, percent: Double, sum: Double, capitalization: Int ) -> Double {
        
        var finalSum = sum
        var i = 0.0
        let duration = Double(Int(Double(durationCalculation(duration: durationLabel.text!)) / 30.41))
        
        switch capitalization {
        case 0:
            if duration  < 1.0 {
                finalSum = finalSum + (finalSum * (percent / 12 / 100))
            } else if duration > 1.0 {
                let percentSum = (finalSum * (percent / 100)  *  duration / 12)
                finalSum = finalSum + percentSum
            }
        case 1:
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
        case 2:
            while  i < duration / 12.0 {
                let percentSum = (finalSum * percent ) / 100
                finalSum = finalSum + percentSum
                i += 1
            }
        default:
            break
        }
        return Double((String(format: "%.2f", finalSum)))  ?? 0.0
    }

    static func dateFromString(_ value: String) -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let newDate = dateFormatter.date(from: value) {
            return newDate
        }
        else {
            return dateFormatter.date(from: "")!
        }
    }
    
    static func dateToString(dateString: Date?) -> String {
         
        var dateResult = ""
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
         
        if  dateString == nil {
            dateResult = ""
        } else {
            dateResult = formatter.string(from: dateString!)
        }
         
        return dateResult
     }
}
