//
//  EmployeeTableViewCell.swift
//  finalPrep
//
//  Created by Adem Hadrovic on 6/9/18.
//  Copyright © 2018 SSST. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var fnameLabel: UILabel!
    
    @IBOutlet weak var lnameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
