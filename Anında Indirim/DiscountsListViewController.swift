//
//  DiscountsListViewController.swift
//  Anında Indirim
//
//  Created by cagin akgul on 19.04.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import UIKit
import Firebase

class DiscountsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    //to read data from db
    var ref: FIRDatabaseReference!
    
    var kafe=[String]() //silebilirsin sistemi oturttuktan sonra
    var shopList = Array<Shop>()
    
    var discountsList = [Discount]()
    var shopArray = [Shop]()

    
    let list=["hodor","hodor2","hodor3"] //silebilirsin sistemi oturttuktan sonra

    @IBOutlet weak var tableVDiscountList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRApp.configure()
        
        //self.tableVDiscountList.delegate=self
        //self.tableVDiscountList.dataSource=self
        
        //for reading data from db
        ref = FIRDatabase.database().reference()
        readSalesFromDB();

        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shopArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DiscountListTableViewCell
        
        cell.labelDummyData.text = self.shopArray[indexPath.row].city
        return cell
    }
  
    func readSalesFromDB()
    {

        // Get shop value
        let objModel = Shop()
        
        ref?.child("shops").observe(.value, with: { (snapshot) in
            for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                if let value = rest.value as? NSDictionary
                {
                    objModel.name = value["name"] as? String ?? ""
                    objModel.city = value["city"] as? String ?? ""
                    objModel.lng = value["lng"] as? String ?? ""
                    objModel.lat = value["lat"] as? String ?? ""
                    objModel.category = value["category"] as? String ?? ""
                    objModel.id = value["id"] as? Int ?? 0
                    
                    //lc waikikinin içindeki discountlara ulaşmaya çalışıyorsun
                    if let discounts = value["discounts"] as! NSDictionary?{ //burda patlıyor
                        
                        var discountArray = [Discount]()
                       // var discountObj:Discount=Discount()
                        for discount in discounts{
                            guard let discountDict = discount.value as? NSDictionary else{
                                return
                            }
                            if let sale_rate = discountDict["sale_rate"] as? String,let product_price_old = discountDict["product_price_old"] as? String,let product = discountDict["product"] as? String,let begin_time = discountDict["begin_time"] as? String{
                                let discountObj = Discount()
                                discountObj.sale_rate = sale_rate
                                discountObj.product = product
                                discountObj.product_price_old = product_price_old
                                discountObj.begin_time = begin_time
                                discountArray.append(discountObj)
                            }
                        }
                        objModel.array = discountArray
                        self.shopArray.append(objModel)
                    }
                }
            }
            self.tableVDiscountList.dataSource = self
            self.tableVDiscountList.delegate = self
            self.tableVDiscountList.reloadData()
        })
    }
}
