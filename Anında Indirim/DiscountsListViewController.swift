//
//  DiscountsListViewController.swift
//  Anında Indirim
//
//  Created by cagin akgul on 19.04.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class DiscountsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate {
    
    
    
    //to read data from db
    var ref: FIRDatabaseReference!
    
    var shopList = Array<Shop>()
    
    var discountsList = [Discount]()
    var shopArray = [Shop]()
    var saleArray = [SaleDisplay]()
    
    var userLat = 0.0
    var userLng = 0.0
    
    //user location
     let locationManager = CLLocationManager()
    var currentLocation: CLLocation!


    @IBOutlet weak var tableVDiscountList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //userlocation
            if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
                currentLocation = locationManager.location
                userLat = currentLocation.coordinate.latitude
                userLng = currentLocation.coordinate.longitude
            }
        
        //for reading data from db
        ref = FIRDatabase.database().reference()
        readSalesFromDB();
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return self.shopArray.count
        return self.saleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DiscountListTableViewCell
        
        //veriler listeye işleniyor. dummydata mağaza adı

        cell.labelDummyData.text = self.saleArray[indexPath.row].name
        cell.lblProductName.text=self.saleArray[indexPath.row].product
        cell.lblOldPrice.text=self.saleArray[indexPath.row].product_price_old
        
        
       let updatedPrice=Utils.sharedInstance.calculateUpdatedPrice(saleRate: self.saleArray[indexPath.row].sale_rate
            , oldPrice: self.saleArray[indexPath.row].product_price_old)
        cell.lblNewPrice.text=updatedPrice
        
        return cell
    }
    
    
  
    func readSalesFromDB()
    {

        // arrayliste eklenecek olan obje ayarlanıyor
        let objModel2=SaleDisplay()
        
        ref?.child("shops").observe(.value, with: { (snapshot) in
            for rest in snapshot.children.allObjects as! [FIRDataSnapshot] {
                if let value = rest.value as? NSDictionary
                {
                   
                    objModel2.name = value["name"] as? String ?? ""
                    objModel2.city = value["city"] as? String ?? ""
                    objModel2.lng = value["lng"] as? String ?? ""
                    objModel2.lat = value["lat"] as? String ?? ""
                    objModel2.category = value["category"] as? String ?? ""
                    objModel2.id = value["id"] as? Int ?? 0

                    
                    //lc waikikinin içindeki discountlara ulaşmaya çalışıyorsun
                    if let discounts = value["discounts"] as! NSDictionary?{
                        
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
                                
                                objModel2.sale_rate = sale_rate
                                objModel2.product = product
                                objModel2.product_price_old = product_price_old
                                objModel2.begin_time = begin_time

                                
                                //kampanya hala geçerli mi? yayın tarihinden itibaren 4 saat oldu mu?
                                
                                let btwHours = Utils.sharedInstance.hours(startDate: Utils.sharedInstance.getCurrentTime(), endDate: Utils.sharedInstance.convertToTime(timeString: begin_time))
                                
                                //ilan son 4 saat içinde yayınlanmışsa display edilecekler listesine ekle
                                if btwHours<5
                                {
                                    //eğer dükkan ile kullanıcı arasında 1km'den az mesafe var ise listeye ekle
                                                                      
                                    let distanceInMeter = Utils.sharedInstance.calcDistanceBtwUserAndShop(userLat: self.userLat, userLong: self.userLng, shopLat: objModel2.lat, shopLng: objModel2.lng)
                                    if distanceInMeter < 1001
                                    {
                                        discountArray.append(discountObj)
                                        print("objmodel2",objModel2.product)
                                        self.saleArray.append(objModel2)
                                    }
                                }
                            
                            }
                        }
                    }
                    
                }
            }
            self.tableVDiscountList.dataSource = self
            self.tableVDiscountList.delegate = self
            self.tableVDiscountList.reloadData()
            
        })
    }
}
