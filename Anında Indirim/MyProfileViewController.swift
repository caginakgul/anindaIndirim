//
//  MyProfileViewController.swift
//  Anında Indirim
//
//  Created by cagin akgul on 9.04.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import SDWebImage


class MyProfileViewController: UIViewController
{

    @IBOutlet weak var ivUserPic: UIImageView!
    @IBOutlet weak var lblUserName: labels!
    //delete it later
    @IBOutlet weak var btLogout: UIButton!
    @IBOutlet weak var btToSale: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //logout button click event delete it later
         btLogout.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        //display sale list events
          btToSale.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        
        
        getUserInfoFirebase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
        
    }
    
    func getUserInfoFirebase()
    {
        let userMailStr=UserDefaults.standard.string(forKey: userEmailKey)
        print("MailsdfsdfsdLog:"+userMailStr!)
        self.lblUserName.text = userMailStr
        self.ivUserPic.image=UIImage(named: "Mail_24px")
        
        //if user logins with facebook
        if FIRAuth.auth()?.currentUser?.photoURL != nil
        {
            let picUrl = FIRAuth.auth()?.currentUser?.photoURL
            ivUserPic.sd_setImage(with: picUrl)
            
            //make imageView circle
      //      Utils.sharedInstance.circleImageView(imageView: ivUserPic)
            
            self.ivUserPic.layer.borderWidth=1.0
            self.ivUserPic.layer.masksToBounds = false
            self.ivUserPic.layer.borderColor = clrFacebookBlue.cgColor
            self.ivUserPic.layer.cornerRadius = self.ivUserPic.frame.size.height/2
            self.ivUserPic.clipsToBounds = true
            

                    //set facebook name
            lblUserName.text=FIRAuth.auth()?.currentUser?.displayName
        }
            //if email login
        else
        {
            
        }
        
    }
    
    func pressButton(button: UIButton) {
        //logout kill session firebase
        try! FIRAuth.auth()!.signOut()
        Utils.sharedInstance.cleanSession()
    }
    
    func pressButtonToTheSale(button: UIButton) {
        //perform segue
        self.performSegue(withIdentifier: "segueToTheSale", sender: self)

        
    }
    
    //to read data from db
}
    


