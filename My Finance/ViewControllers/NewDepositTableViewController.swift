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
    @IBOutlet var aditionalInfo: UITextView!
    @IBOutlet var botomConstraint: NSLayoutConstraint!
    @IBOutlet var aditionalCommentStackView: UIStackView!
    
    var currentDeposit: Deposit?
    
    let bankNamePicker = UIPickerView()
    let datePicker = UIDatePicker()
    let durationPicker = UIPickerView()
    let duration = ["30 дней", "90 дней", "180 дней", "365 дней", "730 дней", "1095 дней", "1825 дней"]
    let bankNames = Banklist.bankNames
  
    var changed = 0
    var tableViewUpdated = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myColor = UIColor.init(red: 74/256, green: 118/256, blue: 168/256, alpha: 1)
        
        aditionalInfo.layer.borderWidth = 1.5
        aditionalInfo.layer.borderColor = myColor.cgColor
        
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
        
        aditionalInfo.inputAccessoryView = toolbar
        

    // Отслеживаем появление клавиатуры
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
           
    // Отслеживаем скрытие клавиатуры
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    //  BankNamePicker and DurationPicker: Methods
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
    
@objc func updateTextView(notification: Notification) {
       
       guard let userInfo = notification.userInfo as? [String: AnyObject],
           let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
           else { return }
       
       if notification.name == UIResponder.keyboardWillHideNotification {
           aditionalInfo.contentInset = UIEdgeInsets.zero
       } else {
           aditionalInfo.contentInset = UIEdgeInsets(top: 0,
                                                left: 0,
                                                bottom: keyboardFrame.height - botomConstraint.constant,
                                                right: 0)
      
           aditionalInfo.scrollIndicatorInsets = aditionalInfo.contentInset
       }
       
       aditionalInfo.scrollRangeToVisible(aditionalInfo.selectedRange)
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
        
        let newDeposit = Deposit(depositName: depositNameLabel.text!,
                                 bankName: bankNameLabel.text ?? "",
                                 startDate: Calculations.dateFromString(startDateLabel.text!),
                                 endDate: endDate(),
                                 duration: durationLabel.text!,
                                 percent: Calculations.persentFloatCheck(numberFromText: percentLabel.text!),
                                 sum: Double(sumLabel.text!) ?? 0.0,
                                 finalSum: Calculations.finalSumCalculation(
                                                            duration: durationCalculation(duration: durationLabel.text!),
                                                            percent: Calculations.persentFloatCheck(numberFromText: percentLabel.text!),
                                                            sum: Double(sumLabel.text!)!,
                                                            capitalization: capitalisationSegment.selectedSegmentIndex),
                                
                                 capitalisationSegment: capitalisationSegment.selectedSegmentIndex,
                                 currencySegment: currencySegment.selectedSegmentIndex,
                                 aditionalInfo: aditionalInfo.text ?? ""
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
                currentDeposit?.aditionalInfo = newDeposit.aditionalInfo
            }
        } else {
                StorageManager.saveObject(newDeposit)
        }
    }

    private func setupEditScreen() {
           
        if currentDeposit != nil {
            
            setupNavigationBar()
               
            depositNameLabel.text = currentDeposit?.depositName
            bankNameLabel.text = currentDeposit?.bankName
            startDateLabel.text = Calculations.dateToString(dateString: currentDeposit?.startDate)
            durationLabel.text = currentDeposit?.duration
            percentLabel.text =  "\(currentDeposit?.percent ?? 0)"
            sumLabel.text = "\(currentDeposit?.sum ?? 0)"
            capitalisationSegment.selectedSegmentIndex = currentDeposit?.capitalisationSegment ?? 0
            currencySegment.selectedSegmentIndex = currentDeposit?.currencySegment ?? 0
            aditionalInfo.text = currentDeposit?.aditionalInfo
           }
       }
    
    private func setupNavigationBar() {
    
        title = currentDeposit?.depositName
        saveButton.isEnabled = true
    }

    private func endDate () -> Date {
        let dateFromString = Calculations.dateFromString(startDateLabel.text!)
        let durationTime = (durationCalculation(duration: durationLabel.text!))
        let endDate = dateFromString.addingTimeInterval((durationTime) * 24 * 60 * 60)
        
        return (endDate)
     }
    
    private func durationCalculation(duration: String) -> Double {
        
        return Double(duration.components(separatedBy: " ").first!) ?? 0.0
    }
    
}
