//
//  OldShoppingTableViewCell.swift
//  Anında Indirim
//
//  Created by cagin akgul on 3.05.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import UIKit

class OldShoppingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblProduct: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
