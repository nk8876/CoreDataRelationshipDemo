//
//  Expense+CoreDataClass.swift
//  CoreDataRelationshipDemo
//
//  Created by Dheeraj Arora on 09/01/20.
//  Copyright © 2020 Dheeraj Arora. All rights reserved.
//
//
import UIKit
import CoreData

@objc(Expense)
public class Expense: NSManagedObject {
    var date : Date?{
        get{
            
            return rawDate as Date?
        }
        set{
            rawDate = newValue! as NSDate
        }
    }
    convenience init?(name: String?, amount: Double, date: Date?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { return nil }
        self.init(entity: Expense.entity(), insertInto: context)
        
        self.name = name
        self.amount = amount
        self.date = date
    }
}
