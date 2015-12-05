//
//  ExpenseTableViewCell.swift
//  eWallet
//
//  Created by David Kababyan on 03/11/2015.
//  Copyright © 2015 David Kababyan. All rights reserved.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
