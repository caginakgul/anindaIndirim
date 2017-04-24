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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //logout button click event delete it later
         btLogout.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        
        
        getUserInfoFirebase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            Utils.sharedInstance.circleImageView(imageView: ivUserPic)
            
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
    
    //to read data from db
}
    


