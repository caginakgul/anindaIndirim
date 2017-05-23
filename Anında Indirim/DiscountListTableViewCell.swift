//
//  DiscountListTableViewCell.swift
//  Anında Indirim
//
//  Created by cagin akgul on 19.04.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import UIKit

class DiscountListTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDummyData: UILabel!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblOldPrice: labels!
    @IBOutlet weak var lblNewPrice: labels!
    @IBOutlet weak var ivCategory: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
