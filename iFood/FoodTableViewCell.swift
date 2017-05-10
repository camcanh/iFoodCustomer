//
//  FoodTableViewCell.swift
//  iFood
//
//  Created by iosdev on 1.5.2017.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit
import CoreData
import MultipeerConnectivity

class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var lblFoodName: UILabel!
    let userDefaults:UserDefaults = UserDefaults()
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBAction func btnOrder(_ sender: Any) {
        let orderDictionary: [String: String] = ["order": lblFoodName.text!, "user": userDefaults.value(forKey: "username") as! String]
        if appDelegate.foodConnect.sendData(dictionaryWithData: orderDictionary, toPeer: appDelegate.foodConnect.session.connectedPeers[0] as MCPeerID) {
            print("food data sent")
            
        } else {
            print ("Could not send data")
        }
        let messageDictionary: [String: String] = ["message": "I want a "+lblFoodName.text!, "sender": userDefaults.value(forKey: "username") as! String]
        if appDelegate.foodConnect.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.foodConnect.session.connectedPeers[0] as MCPeerID) {
            print("user data sent")
            
        } else {
            print ("Could not send data")
        }
    }
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var imgFood: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
