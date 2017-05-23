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

//todo : veriyi table'a yazdırmayı çöz.


class MyProfileViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{
    var ref: FIRDatabaseReference!
    @IBOutlet weak var ivUserPic: UIImageView!
    @IBOutlet weak var lblUserName: labels!
    
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var tableOldShopping: UITableView!
    //var oldShoppingArray = [OldShopping]()
    var oldShoppingArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //logout button click event delete it later
        btnLogout.addTarget(self, action: #selector(self.pressButton(button:)), for: .touchUpInside)
        
        ref = FIRDatabase.database().reference()
        
        //seperatorleri ortadan kaldırmak için
        self.tableOldShopping.tableFooterView = UIView()
        
        getUserInfoFirebase()
        readOldShoppingFromDB()
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
        
         self.performSegue(withIdentifier: "segueLogout", sender: self) 
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return self.shopArray.count
        return self.oldShoppingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OldShoppingTableViewCell
        
        //veriler listeye işleniyor. dummydata mağaza adı
        
        let shopping = self.oldShoppingArray[indexPath.row] as! OldShopping
        
        cell.lblProduct.text = shopping.product
        cell.lblDate.text = shopping.time

        
        return cell
    }
    
    
    
    func readOldShoppingFromDB()
    {
    
        // arrayliste eklenecek olan obje ayarlanıyor
        if let userid = UserDefaults.standard.string(forKey: userIdKey){
            ref?.child("shopping").child(userid).observe(.value, with: { (snapshot) in
                    for rest in snapshot.children.allObjects as! [FIRDataSnapshot]
                    {
                        let objModel=OldShopping()
                        if let value = rest.value as? NSDictionary
                        {
                            //objModel.product=value["product"] as? String ?? ""
                            
                            guard let product_name = value.object(forKey: "product") else{
                                return
                            }
                            guard let time = value.object(forKey: "time") else{
                                return
                            }
                        
                            
                            objModel.product = product_name as! String
                            objModel.time = time as! String
                            
                            //self.oldShoppingArray.append(objModel)
                            self.oldShoppingArray.add(objModel)
                        }
                    }
                self.tableOldShopping.dataSource=self
                self.tableOldShopping.delegate = self
                self.tableOldShopping.reloadData()
            })
        }
    }
    
    func buttonRound()
    {
        btnLogout.backgroundColor = clrButtonGreen
        btnLogout.layer.cornerRadius = 10
        btnLogout.layer.borderWidth = 1
        btnLogout.layer.borderColor = clrButtonGreen.cgColor
    }

}
