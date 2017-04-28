//
//  ViewController.swift
//  Anında Indirim
//
//  Created by cagin akgul on 13.12.2016.
//  Copyright © 2016 cagin akgul. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import Crashlytics

class ViewController: UIViewController {
    
    // Firebase Database Referance
    var ref: FIRDatabaseReference!

    @IBOutlet weak var lblPass: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btLoginMail: UIButton!
    @IBOutlet weak var btConnectFace: roundButton!
    @IBOutlet weak var btToRegister: textButton!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         FIRApp.configure()
  
        // Firebase Database Referance
        ref = FIRDatabase.database().reference()
        
        //checkSession
        checkSession()
        
        //textfield içi resim yerleştirme
        Utils.sharedInstance.iconTextField(textField: tfEmail,picName:"Mail_24px")
        Utils.sharedInstance.iconTextField(textField: tfPassword,picName:"Open-Lock_24px")
        
        //login click event
        btLoginMail.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        btConnectFace.addTarget(self, action: #selector(self.fbLogin), for: .touchUpInside)
        btToRegister.addTarget(self, action: #selector(self.pressButtonToRegister(button:)), for: .touchUpInside)
        
        //force crash sample Crashlytics
      /*  let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        button.setTitle("Crash", for: [])
        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button) */

    }
    
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        Crashlytics.sharedInstance().crash()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkSession()
    {
        if FIRAuth.auth()?.currentUser != nil {
           toMain()
           NSLog("there is", "there is")
            
        }
        else {
            //User Not logged in
            NSLog("there isnt", "there isnt")

        }
    }
    
    func fbLogin(button: UIButton) {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self) { (result:FBSDKLoginManagerLoginResult?, error:Error?) in
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            
            FIRAuth.auth()?.signIn(with: credential) { (user: FIRUser?, error) in
                if let error = error {
                    print("Login failed. \(error)")
                    return
                }else{
                    if user != nil{
                        //add user to the database
                        self.ref.child("users").child((user?.uid)!).setValue([userNameKey: user?.displayName, userEmailKey: user?.email ])
                        
                        //keep information in session
                        UserDefaults.standard.set((user?.email)!, forKey: userEmailKey)
                        UserDefaults.standard.set((user?.uid)!, forKey: userIdKey)
                        
                        //use segue to change screen
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "loggedInEmail", sender: nil)
                        }
                    }
                    return
                }
            }
        }
    }
    
    func pressButton(button: UIButton) {
        checkFieldsLogin()
    }

    func pressButtonToRegister(button: UIButton)
    {
            toRegister()
    }
    
    func toRegister()
    {
        self.performSegue(withIdentifier: "segueToRegister", sender: self)
    }
    
    func toMain()
    {
        DispatchQueue.main.async() {
            [unowned self] in
            self.performSegue(withIdentifier: "loggedInEmail", sender: self)
        }
    }

    
    func checkFieldsLogin()
    {
        
        if tfEmail.text == "" || tfPassword.text == ""
        {
            Utils.sharedInstance.printAlert(titlePrm: formAlertTitleNiceTry, message: fillForm, context: self)
        }
        else
        {   //form is filled
            
                if Utils.sharedInstance.isValidEmail(testStr: tfEmail.text!)  //email is valid
                {
                    login()
                }
                else
                {     //email is not valid
                    Utils.sharedInstance.printAlert(titlePrm: formAlertTitleNiceTry, message: invalidEmail, context: self)
                }
        }
    }
    
    func login()
    {
                FIRAuth.auth()?.signIn(withEmail: self.tfEmail.text!, password: self.tfPassword.text!) { (user, error) in
                if error == nil { //giriş başarılı
                    //keep session
                     UserDefaults.standard.set((user?.email)!, forKey: userEmailKey)
                     UserDefaults.standard.set((user?.uid)!, forKey: userIdKey)
                    
                     print("MailLogLogin:"+(user?.email)!)
                    
                    //perform segue
                    self.performSegue(withIdentifier: "loggedInEmail", sender: self)
                }
                else {
                    Utils.sharedInstance.printAlert(titlePrm: sorry, message: noUserFound, context: self)
                }
            }
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

