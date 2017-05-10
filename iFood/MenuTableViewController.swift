//
//  MenuTableViewController.swift
//  iFood
//
//  Created by iosdev on 1.5.2017.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit
import CoreData
class MenuTableViewController: UITableViewController {
    
    var kindOfFood = ["Drinks", "Desserts", "Main Dishes", "Starters", "Side Dishes"]
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        let firstStart1: Bool? = UserDefaults.standard.object(forKey: "firstStart1") as? Bool
        
        if firstStart1 == nil {
            self.createFoodData()
            
            
            UserDefaults.standard.set(false, forKey: "firstStart1")
        }

    }

    func createFoodData() {
        
        let food: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "Food", in: context)
        if food != nil {
            
            let hamburger: Food = Food(entity: food!, insertInto: context)
            hamburger.name = "Hamburger"
            hamburger.kind = kindOfFood[2]
            hamburger.info = "Good hamburger with chicken or beef and salad"
            hamburger.id = 1
            hamburger.imageName = "hamburger.jpg"
            hamburger.price = 8.00
            
            let pizza: Food = Food(entity: food!, insertInto: context)
            pizza.name = "Pizza"
            pizza.kind = kindOfFood[2]
            pizza.info = "Good pizza with chicken or beef"
            pizza.id = 2
            pizza.imageName = "pizza.png"
            pizza.price = 10.00
            
            let chips: Food = Food(entity: food!, insertInto: context)
            chips.name = "Chips"
            chips.kind = kindOfFood[4]
            chips.info = "Fries"
            chips.id = 3
            chips.imageName = "chips.jpg"
            chips.price = 3.00
            
            let cocacola: Food = Food(entity: food!, insertInto: context)
            cocacola.name = "Cocacola"
            cocacola.kind = kindOfFood[0]
            cocacola.info = "Cocacola with ice"
            cocacola.id = 4
            cocacola.imageName = "cocacola.jpg"
            cocacola.price = 2.50
            
            let banana: Food = Food(entity: food!, insertInto: context)
            banana.name = "Fried Banana with Ice Cream"
            banana.kind = kindOfFood[1]
            banana.info = "Fried Banana with Ice Cream"
            banana.id = 5
            banana.imageName = "banana.jpg"
            banana.price = 4.50
            
            let springRolls: Food = Food(entity: food!, insertInto: context)
            springRolls.name = "Spring Rolls"
            springRolls.kind = kindOfFood[4]
            springRolls.info = "Vietnamese Spring Rolls"
            springRolls.id = 6
            springRolls.imageName = "springrolls.jpg"
            springRolls.price = 2.20
            
            
            self.appDelegate.saveContext()
            
            
            
        }
        
        
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
        return kindOfFood.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        cell.menuImg.image = UIImage(named: (kindOfFood[indexPath.row] + ".jpg"))
        cell.menuLabel.text = kindOfFood[indexPath.row]

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let chosenKind: String? = UserDefaults.standard.object(forKey: "chosenKind") as? String
        if (indexPath.row == 0) {
            UserDefaults.standard.set("Drinks",forKey:"chosenKind")
            
        }
        if (indexPath.row == 1) {
            UserDefaults.standard.set("Desserts",forKey:"chosenKind")
            
        }
        if (indexPath.row == 2) {
            UserDefaults.standard.set("Main Dishes",forKey:"chosenKind")
            
        }
        if (indexPath.row == 3) {
            UserDefaults.standard.set("Starters",forKey:"chosenKind")
            
        }
        if (indexPath.row == 4) {
            UserDefaults.standard.set("Side Dishes",forKey:"chosenKind")
            
        }
        
        performSegue(withIdentifier: "SegueToThird", sender: self)
    }
    
    }
