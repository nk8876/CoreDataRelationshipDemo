//
//  Category+CoreDataClass.swift
//  CoreDataRelationshipDemo
//
//  Created by Dheeraj Arora on 09/01/20.
//  Copyright © 2020 Dheeraj Arora. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Category)
public class Category: NSManagedObject {
    
    var expenses : [Expense]?{
        return self.rawExpenses?.array as? [Expense]
    }
    convenience init?(title: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { return nil }
        self.init(entity: Category.entity(), insertInto: context)
        self.title = title
    }

}
