//
//  ViewController.swift
//  CoreDataRelationshipDemo
//
//  Created by Dheeraj Arora on 09/01/20.
//  Copyright © 2020 Dheeraj Arora. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UIViewController {
    
    var categories: [Category] = []
    @IBOutlet weak var categoryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Category> = Category.fetchRequest()
        do {
           categories = try manageContext.fetch(fetchRequest)
            categoryTableView.reloadData()
        } catch  {
            print("coudl not fetched data")
        }
    }
    
    func deleteCategory(at indexPath: IndexPath) {
        let category = categories[indexPath.row]
        guard let manageContext = category.managedObjectContext else { return  }
        manageContext.delete(category)
        do {
            try manageContext.save()
            categories.remove(at: indexPath.row)
            categoryTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch  {
            print("coudl not delete category")
            categoryTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

}

extension CategoryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenceCategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            deleteCategory(at: indexPath)
        }
    }
    
}
extension CategoryViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedRow = self.categoryTableView.indexPathForSelectedRow?.row else { return }
        let destination = self.storyboard?.instantiateViewController(withIdentifier: "ExpenceViewController") as! ExpenceViewController
        destination.category = categories[selectedRow]
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
}
