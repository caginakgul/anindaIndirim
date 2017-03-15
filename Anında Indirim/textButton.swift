//
//  textButton.swift
//  Anında Indirim
//
//  Created by cagin akgul on 15.03.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import UIKit

class textButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.titleLabel?.textColor = clrGrayTextButton
    }

}
