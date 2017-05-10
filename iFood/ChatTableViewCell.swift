//
//  ChatTableViewCell.swift
//  iFood
//
//  Created by iosdev on 8.5.2017.
//  Copyright © 2017 Tien. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDetail: UILabel!
    
    @IBOutlet weak var lblMsg: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
