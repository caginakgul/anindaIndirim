//
//  textField.swift
//  Anında Indirim
//
//  Created by cagin akgul on 15.03.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import UIKit

class textField: UITextField {
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 2.0
        self.layer.borderColor = clrTextFieldBorder.cgColor
       // iconTextField()
              
        
        
    }
 
       
    func iconTextField()
    {
        self.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "Open-Lock_24px")
        imageView.image = image
        self.leftView = imageView
    }


}
