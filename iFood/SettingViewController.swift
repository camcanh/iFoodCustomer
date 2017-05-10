//
//  SettingViewController.swift
//  iFood
//
//  Created by iosdev on 08/05/17.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class SettingViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func endFood(_ sender: AnyObject) {
        let messageDictionary: [String: String] = ["message": "_good_bye_"]
        if appDelegate.foodConnect.sendData(dictionaryWithData: messageDictionary, toPeer: appDelegate.foodConnect.session.connectedPeers[0] as MCPeerID){
            self.dismiss(animated: true, completion: { () -> Void in
                self.appDelegate.foodConnect.session.disconnect()
                
            })
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
