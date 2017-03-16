//
//  ViewController.swift
//  Anında Indirim
//
//  Created by cagin akgul on 13.12.2016.
//  Copyright © 2016 cagin akgul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblPass: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btLoginMail: UIButton!
    @IBOutlet weak var btConnectFace: UIButton!
    @IBOutlet weak var btToRegister: textButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColor()
        
        

        //buttonRound()
        
                // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setColor()
    {
        self.lblPass.textColor=clrLabelLogin
        self.lblEmail.textColor=clrLabelLogin
    }
    
    func buttonRound()
    {
        btLoginMail.backgroundColor = clrButtonGreen
        btLoginMail.layer.cornerRadius = 10
        btLoginMail.layer.borderWidth = 1
        btLoginMail.layer.borderColor = clrButtonGreen.cgColor
    }


}

