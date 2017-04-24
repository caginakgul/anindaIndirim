//
//  RegisterViewController.swift
//  Anında Indirim
//
//  Created by cagin akgul on 21.03.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class RegisterViewController: UIViewController {
    
    // Firebase Database Referance
    var ref: FIRDatabaseReference!

    @IBOutlet weak var tfEmailReg: textField!
    @IBOutlet weak var tfUNameReg: textField!
    @IBOutlet weak var tfPassReg: textField!
    @IBOutlet weak var tfPassAgainReg: textField!
    @IBOutlet weak var btRegister: roundButton!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Firebase Database Referance
        ref = FIRDatabase.database().reference()
        
        //textfield içi resim yerleştirme
        Utils.sharedInstance.iconTextField(textField: tfEmailReg,picName:"Mail_24px")
        Utils.sharedInstance.iconTextField(textField: tfPassReg,picName:"Open-Lock_24px")
        Utils.sharedInstance.iconTextField(textField: tfPassAgainReg,picName:"Open-Lock_24px")
        Utils.sharedInstance.iconTextField(textField: tfUNameReg,picName:"User_24px")
        
        //button click event
        btRegister.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        self.view.addSubview(btRegister)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pressButton(button: UIButton) {
        checkFields()
    }
    
    
    func checkFields()
    {
        if tfEmailReg.text == "" || tfPassReg.text == "" || tfPassAgainReg.text=="" || tfUNameReg.text==""
        {
             Utils.sharedInstance.printAlert(titlePrm: formAlertTitleNiceTry, message: fillForm, context: self)
        }
        else
        {   //form is filled
            let isEqual = (tfPassReg.text == tfPassAgainReg.text)
            if(isEqual)
            { //passwords are equal
                    
                if Utils.sharedInstance.isValidEmail(testStr: tfEmailReg.text!)   //check email is valid
                {
                     register()
                }
                else
                {
                    Utils.sharedInstance.printAlert(titlePrm: formAlertTitleNiceTry, message: invalidEmail, context: self)
                }
                
            }
            else   //passwords are not equal
            {
                 Utils.sharedInstance.printAlert(titlePrm: formAlertTitleNiceTry, message: notEqualPasswords, context: self)
            }

        }
        
    }
    
    func register()
    {
        FIRAuth.auth()?.createUser(withEmail: tfEmailReg.text!, password: tfPassReg.text!)
        {
            (user, error) in
            if error==nil
            {
                //add user to the database
                self.ref.child("users").child((user?.uid)!).setValue([userNameKey: self.tfUNameReg.text, userEmailKey: self.tfEmailReg.text ])
                //, deviceTypeKey:ios, loginTypeKey:email bunları da veritabanına eklemek isteyince çalışmıyor
                
                //set userDefaults for session
                UserDefaults.standard.set(self.tfEmailReg.text, forKey: userEmailKey)
                UserDefaults.standard.set((user?.uid)!, forKey: userIdKey)
                
                print("MailLogReg:"+self.tfEmailReg.text!)

                //perform segue
                self.performSegue(withIdentifier: "segueRegisterToMain", sender: self)
            }
           
        }
    }
    
          
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
