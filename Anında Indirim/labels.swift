//
//  labels.swift
//  Anında Indirim
//
//  Created by cagin akgul on 16.03.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import UIKit

class labels: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
          super.layoutSubviews()
          self.textColor = clrLabel
          self.font = self.font.withSize(14)
    }
}
