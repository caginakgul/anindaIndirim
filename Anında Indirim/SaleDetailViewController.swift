//
//  SaleDetailViewController.swift
//  Anında Indirim
//
//  Created by cagin akgul on 27.04.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SaleDetailViewController: UIViewController {
    
    var locationManager:CLLocationManager?
    var mapView:MKMapView?
    var currentLocation:CLLocation

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager=CLLocationManager()
        locationManager?.delegate=self as! CLLocationManagerDelegate
        locationManager?.startUpdatingLocation()
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        
        //stckoverflow çözünü
        
        self.locationManager?.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager?.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self as! CLLocationManagerDelegate
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
        }

     
    }
    //stackoverflow metodu
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func locationManager(_manager:CLLocationManager,didUpdateLocations locations:[CLLocation])
    {
        self.currentLocation=locations[0]
        
    }
    
    func locationManager(_manager:CLLocationManager, didFailWithError error: Error)
    {
        
    }
    
    @IBAction func saveLocation(_ sender:AnyObject)
    {
      //  let mapPin:MapPin=MapPin(title:"Title", subtitle:"Subtitle", coordinate:currentLocation.coordinate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
