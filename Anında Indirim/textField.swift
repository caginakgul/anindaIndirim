//
//  textField.swift
//  Anında Indirim
//
//  Created by cagin akgul on 15.03.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import UIKit

class textField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 2.0
        //self.layer.borderColor = clrTextFieldBorder
    }


}
