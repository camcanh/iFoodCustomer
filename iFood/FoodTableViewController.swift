//
//  FoodTableViewController.swift
//  iFood
//
//  Created by iosdev on 1.5.2017.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit
import CoreData
import MultipeerConnectivity

class FoodTableViewController: UITableViewController {

        var name:[String] = []
        var price:[Double] = []
        var image:[String] = []
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let userDefaults:UserDefaults = UserDefaults()
    
        
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Food")
            request.returnsObjectsAsFaults = false
            let chosen = userDefaults.value(forKey: "chosenKind") as! String
            do {
                let foods = try context.fetch(request)
                for food in foods {
                    let foodName = (food as AnyObject).value(forKey: "name") as! String
                    let foodPrice = (food as AnyObject).value(forKey: "price") as! Double
                    let imgName = (food as AnyObject).value(forKey: "imageName") as! String
                    let foodKind = (food as AnyObject).value(forKey: "kind") as! String
                    //print(chosen)
                    //print(foodKind)
                    if (foodKind == chosen) {
                        name.append(foodName)
                        price.append(foodPrice)
                        image.append(imgName)
                        print(String(name.count))
                    }
                    
                    
                }
                
            } catch {
                print(error)
            }
            
        }
    
    func searchBarSetup() {
        let searchBar = UISearchBar(frame: CGRect(x:0,y:0,width:(UIScreen.main.bounds.width),height:70))
        searchBar.showsScopeBar = true
        
        self.tableView.tableHeaderView = searchBar
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return name.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food", for: indexPath) as! FoodTableViewCell
        cell.lblFoodName.text = name[indexPath.row]
        cell.lblFoodPrice.text = String(price[indexPath.row])
        cell.imgFood.image = UIImage(named: image[indexPath.row])

        return cell
    }
    
}

