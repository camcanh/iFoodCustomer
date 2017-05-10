//
//  ViewController.swift
//  iFood
//
//  Created by iosdev on 23.4.2017.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit
import CoreData
import MultipeerConnectivity

class ViewController: UIViewController {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var lblAlert: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblWelcome: UILabel!

    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblWelcome.text = "iFood"
        lblAlert.text = ""
        
        let firstStart: Bool? = UserDefaults.standard.object(forKey: "firstStart") as? Bool
        
        if firstStart == nil {
            self.createUserData()
            
            UserDefaults.standard.set(false, forKey: "firstStart")
        }
    }
    
    
    @IBAction func hideKeyboard(_ sender: UIButton) {
            self.txtUsername.resignFirstResponder()
            self.txtPassword.resignFirstResponder()
    }
    
    @IBAction func btnAction(_ sender: Any) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        
        do {
            let users = try context.fetch(request)
            
            for u in users {
                let usn = (u as AnyObject).value(forKey: "userName") as! String
                let psw = (u as AnyObject).value(forKey: "password") as! String
                
                if (txtUsername.text == usn) && (txtPassword.text == psw){
                    UserDefaults.standard.set(usn, forKey: "username")
                    lblAlert.text = "Logging in.."
                    performSegue(withIdentifier: "SegueToSecond", sender: self)
                } else {
                    
                    lblAlert.text = "*incorrect username or password !"
                    
                }
            }
            
            
        } catch {
            print("error")
        }
        
    }
    
    
    func createUserData() {
        let user: NSEntityDescription? = NSEntityDescription.entity(forEntityName: "User", in: context)
        if user != nil {
            
            let user1: User = User(entity: user!, insertInto: context)
            user1.userName = "table1"
            user1.password = "table1"
            user1.id = 2
            
            let user2: User = User(entity: user!, insertInto: context)
            user2.userName = "admin"
            user2.password = "admin"
            user2.id = 1
            
            self.appDelegate.saveContext()
            
        }
        
        
    }
    
    
    
    
}

