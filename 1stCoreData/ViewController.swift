//
//  ViewController.swift
//  1stCoreData
//
//  Created by 王杰 on 2022/8/11.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var tableview: UITableView = {
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    var models = [CoreDataItem]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Do it"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(tableview)
        getallItems()
        tableview.frame = view.bounds
        tableview.delegate = self
        tableview.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.createItem(itemName: text)
        }))
        present(alert, animated: true)
    }
    
    func getallItems() {
        do {
            models = try context.fetch(CoreDataItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        } catch {
            
        }
    }
    
    func createItem(itemName: String) {
        let newItem = CoreDataItem(context: context)
        newItem.itemName = itemName
        newItem.itemDate = Date()
        do {
            try context.save()
            getallItems()
        } catch {
            
        }
    }
    
    func deleteItem(item: CoreDataItem) {
        context.delete(item)
        do {
            try context.save()
            getallItems()
        } catch {
            
        }
        
    }
    
    func updateItems(item: CoreDataItem, itemName: String) {
        item.itemName = itemName
        do {
            try context.save()
            getallItems()
        } catch {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].itemName
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        
        let item = models[indexPath.row]
        
        let sheet = UIAlertController(title: "Menu⬇️", message: nil, preferredStyle: .alert)
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edit Item",
                                          message: "Edit your item",
                                          preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.itemName
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let itemName = field.text, !itemName.isEmpty else {
                    return
                }
                self?.updateItems(item: item, itemName: itemName)
            }))
            self.present(alert, animated: true)
        }))
        
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        present(sheet, animated: true)
    }
}

