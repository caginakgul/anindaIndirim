//
//  Utils.swift
//  Anında Indirim
//
//  Created by cagin akgul on 23.03.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import Foundation
import UIKit

class Utils{
    
    static let sharedInstance = Utils()
    
    func printAlert(titlePrm:String,message:String, context:UIViewController)
    {
        let alert = UIAlertController(title: titlePrm, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default, handler: nil))
        context.present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    func iconTextField(textField: UITextField, picName:String)
    {
        textField.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 14, height: 14))
        let image = UIImage(named: picName)
        imageView.image = image
        textField.leftView = imageView
        textField.leftView?.frame.origin.x += 10
        
        //textfield içindeki resime soldan padding verir
        if let size = imageView.image?.size {
            imageView.frame = CGRect(x: 0.0, y: 0.0, width: size.width + 20.0, height: size.height+43.0)
        }
        imageView.contentMode = UIViewContentMode.center
        textField.leftView = imageView
        textField.leftViewMode = UITextFieldViewMode.always
    }
    
    func cleanSession()
    {
        UserDefaults.standard.set("", forKey: userEmailKey)
        UserDefaults.standard.set("", forKey: userIdKey)
    }
    
    func circleImageView(imageView: UIImageView)
    {
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
    }
}

