//
//  Utils.swift
//  Anında Indirim
//
//  Created by cagin akgul on 23.03.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

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
    
    func convertToTime(timeString: String)->Date
    {
        var interval:Double = 0
        
        let parts = timeString.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }

        var date = NSDate(timeIntervalSince1970: interval)
        print("Begin Time: ",date)
        return date as Date
    }
    
    func getCurrentTime()->Date
    {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        let today = "\(year):\(month):\(day): \(hour):\(minutes):\(seconds)"
        
        
       return date
      /*  let now = Date()
        print("Now: ",now)
        return now */
    }
    
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: endDate, to: startDate)
        return components.day!
    }
    
    func hours(startDate: Date, endDate: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: endDate, to: startDate).hour ?? 0
    }
    
    func calculateUpdatedPrice(saleRate: String, oldPrice: String)->String
    {
         print("sale rate: ",saleRate)
         print("old price : ",oldPrice)
        
        var updatedPrice = 0.0
        let oldPriceDouble = Double(oldPrice ) ?? 0.0
        let saleRateDouble = Double(saleRate ) ?? 0.0
        updatedPrice = oldPriceDouble*saleRateDouble
        
        print("Çarpım: ",updatedPrice)
        
        updatedPrice = updatedPrice/100
        
        print("kaç tl indirim yapılcak: ",oldPrice)
        
        updatedPrice = oldPriceDouble - updatedPrice
        
          print("yeni fiyat: ",oldPrice)
        let newPriceStr:String = String(format:"%.2f", updatedPrice)
        print("yeni fiyat: ",newPriceStr)
        return newPriceStr
    }
    
    func calcDistanceBtwUserAndShop(userLat: Double, userLong: Double, shopLat: String, shopLng: String) -> Int
    {
        let shopLatDbl = Double(shopLat)
        let shopLngDbl = Double(shopLng)
        
        let coordinateUser = CLLocation(latitude: userLat, longitude: userLong)
        let coordinateShop = CLLocation(latitude: shopLatDbl!, longitude: shopLngDbl!)
        
        let distanceInMeters = coordinateUser.distance(from: coordinateShop) // result is in meters
        return Int(distanceInMeters)
    }
    
    func convertDouble(prmStr: String)->Double
    {
        let dblValue = Double(prmStr)

        return dblValue!
    }
    
  }

