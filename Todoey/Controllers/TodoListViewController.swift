//
//  ViewController.swift
//  Todoey
//
//  Created by Angela Yu on 16/11/2017.
//  Copyright © 2017 Angela Yu. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

    }
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let vc = AddInfoVC(nibName: "AddInfoVC", bundle: nil)
        vc.status = 0
         vc.closure = { task in
            let newItem = Item(context: self.context)
            newItem.date = task.date
            newItem.haq = task.haqdorligi
            newItem.qarz = task.qarzdorligi
            newItem.photo1 = task.photo1
            newItem.photo2 = task.photo2
            newItem.other = task.boshqa
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            self.saveItems()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Model Manupulation Methods
    func saveItems() {
        do {
          try context.save()
        } catch {
           print("Error saving context \(error)")
            errorAlert("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }

        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
            errorAlert("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    func errorAlert(_ title: String) {
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell else { return UITableViewCell() }
        
        let item = itemArray[indexPath.row]
        cell.dateLabel.text = item.date
        cell.qarzdorlikLabel.text = item.qarz
        cell.photo1.image = UIImage(data: item.photo1!)
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let vc = AddInfoVC(nibName: "AddInfoVC", bundle: nil)
        vc.status = 1
        let item = itemArray[indexPath.row]
        vc.showPhoto1 = UIImage(data: item.photo1!)
        vc.showPhoto2 = UIImage(data: item.photo2!)
        vc.haq = item.haq ?? ""
        vc.other = item.other ?? ""
        vc.qarz = item.qarz ?? ""
    
        vc.closure = { task in
            let newItem = Item(context: self.context)
            newItem.date = task.date
            newItem.haq = task.haqdorligi
            newItem.qarz = task.qarzdorligi
            newItem.photo1 = task.photo1
            newItem.photo2 = task.photo2
            newItem.other = task.boshqa
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            self.saveItems()
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "O'chirish") { [self] _,_,_ in
            
            context.delete(itemArray[indexPath.row])
            itemArray.remove(at: indexPath.row)
            saveItems()
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        deleteAction.backgroundColor = UIColor.red
        let swipe = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipe
    }
}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "date CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}








