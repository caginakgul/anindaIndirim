//
//  roundButton.swift
//  Anında Indirim
//
//  Created by cagin akgul on 15.03.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import UIKit

class roundButton: UIButton {
    @IBInspectable var cornerRadius:CGFloat = 15.0
    @IBInspectable var bgColor:UIColor = clrButtonGreen
    @IBInspectable var borderColor:UIColor = clrButtonGreen

    /*
    top side is editable by ui   */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = self.bgColor
        self.titleLabel?.textColor = clrTextWhite
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = 1
        self.layer.borderColor = self.borderColor.cgColor
    }
}
