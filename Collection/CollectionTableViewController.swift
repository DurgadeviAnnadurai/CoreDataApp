//
//  CollectionTableViewController.swift
//  Collection
//
//  Created by Durgadevi Annadurai on 12/10/2019.
//  Copyright © 2019 Durgadevi Annadurai. All rights reserved.
//

import UIKit

class CollectionTableViewController: UITableViewController {

    var outputCollection:[CollectionData]=[]
    override func viewDidLoad() {
        super.viewDidLoad()
       
   
    }
  override func viewWillAppear(_ animated: Bool) {
      getCollections()
    tableView.reloadData()
   
    
  }
   func getCollections(){
       if let context=(UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
              {
                  if let allOutput = try? context.fetch(CollectionData.fetchRequest())
                  {
                      if let Output = allOutput as? [CollectionData]
                      {
                       outputCollection=Output
                      }
                       }
              }
    
   }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell=UITableViewCell()
        let collections=outputCollection[indexPath.row]
        cell.textLabel?.text=collections.title
        if let data=collections.image
        {
            cell.imageView?.image=UIImage(data: data)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return outputCollection.count
    }
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            if let context=(UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            {
        context.delete(outputCollection[indexPath.row])
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            }
        }
        tableView.reloadData()
    }

 }
