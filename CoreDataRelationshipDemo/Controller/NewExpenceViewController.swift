//
//  NewExpenceViewController.swift
//  CoreDataRelationshipDemo
//
//  Created by Dheeraj Arora on 09/01/20.
//  Copyright © 2020 Dheeraj Arora. All rights reserved.
//

import UIKit

class NewExpenceViewController: UIViewController {
    
    
    @IBOutlet weak var txtExpenceName: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    var category: Category?
    var datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtExpenceName.delegate = self
        txtAmount.delegate = self
        txtDate.delegate = self
        
        self.txtDate.setInputViewDatePicker(target: self, selector: #selector(tapDone))

       
    }
    
    @objc func tapDone() {
        if let datePicker = self.txtDate.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .long
            self.txtDate.text = dateformatter.string(from: datePicker.date)
        }
        self.txtDate.resignFirstResponder()
    }
    @IBAction func btnSaveExpenceAction(_ sender: UIBarButtonItem) {
        
        let name = txtExpenceName.text
        let amountText = txtAmount.text ?? ""
        let amount = Double(amountText) ?? 0.0
        let date =  datePicker.date
        
        if let expense = Expense(name: name, amount: amount, date: date){
            category?.addToRawExpenses(expense)
            
            do {
                try expense.managedObjectContext?.save()
                self.navigationController?.popViewController(animated: true)
            }catch{
                print("Expense coudl not be created")
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtAmount.resignFirstResponder()
        txtExpenceName.resignFirstResponder()
    }
   
}

extension NewExpenceViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
}
extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}
