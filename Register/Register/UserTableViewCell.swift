//
//  UserTableViewCell.swift
//  Register
//
//  Created by Naveen on 20/07/16.
//  Copyright © 2016 naveen. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

  @IBOutlet weak var photo: UIImageView!
  
  
  @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
