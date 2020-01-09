//
//  ExpenceViewController.swift
//  CoreDataRelationshipDemo
//
//  Created by Dheeraj Arora on 09/01/20.
//  Copyright © 2020 Dheeraj Arora. All rights reserved.
//

import UIKit

class ExpenceViewController: UIViewController {
    
    
    @IBOutlet weak var expenceTableView: UITableView!
    var dateFormatter = DateFormatter()
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
          dateFormatter.timeStyle = .long
          dateFormatter.dateStyle = .long
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.expenceTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? NewExpenceViewController else { return }
         destination.category = category
    }
    
    func deleteExpense(at indexPath: IndexPath) {
        guard let expense = category?.expenses?[indexPath.row], let manageContext = expense.managedObjectContext else { return  }
        manageContext.delete(expense)
        do {
            try manageContext.save()
            expenceTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch  {
            print("coudl not delete category")
            expenceTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ExpenceViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category?.expenses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenceCell", for: indexPath)
        
        if let expense = category?.expenses?[indexPath.row]{
            cell.textLabel?.text = expense.name
            
            if let date = expense.date{
                cell.detailTextLabel?.text = dateFormatter.string(from: date)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteExpense(at: indexPath)
        }
    }
}

extension ExpenceViewController: UITableViewDelegate{
    
    
}
