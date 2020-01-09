//
//  NewCategoryViewController.swift
//  CoreDataRelationshipDemo
//
//  Created by Dheeraj Arora on 09/01/20.
//  Copyright © 2020 Dheeraj Arora. All rights reserved.
//

import UIKit

class NewCategoryViewController: UIViewController {
    
    
    @IBOutlet weak var txtCategoryTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       txtCategoryTitle.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtCategoryTitle.resignFirstResponder()
    }

    @IBAction func btnSaveCategoryAction(_ sender: UIBarButtonItem) {
        let category = Category(title: txtCategoryTitle.text ?? "")
        do {
            try category?.managedObjectContext?.save()
            self.navigationController?.popViewController(animated: true)
        } catch  {
            print("coudl not save category")
        }
    }
    
}

extension NewCategoryViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
