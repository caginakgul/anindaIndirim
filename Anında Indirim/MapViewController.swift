//
//  MapViewController.swift
//  Anında Indirim
//
//  Created by cagin akgul on 8.05.2017.
//  Copyright © 2017 cagin akgul. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase

class MapViewController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btGetCode: UIButton!
    @IBOutlet weak var ivQr: UIImageView!
    var qrcodeImage: CIImage!
    
    var display : SaleDisplay!
     var ref: FIRDatabaseReference!
    
    var sourceLocation:CLLocationCoordinate2D!
    var destinationLocation:CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //openMapForPlace()
        ref = FIRDatabase.database().reference()
        
        self.mapView.delegate = self
        
        btGetCode.addTarget(self, action: #selector(self.pressButton), for: .touchUpInside)

        
        // 3.
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 4.
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 5.
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Konumunuz"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = self.display.name
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6.
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        // 7.
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.mapView.add((route.polyline), level: MKOverlayLevel.aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .red
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pressButton(button: UIButton) {
        
        //qr kod yaratma işlemleri
        if qrcodeImage == nil {
            
            let data = self.display.product.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter?.outputImage
            displayQRCodeImage()
        }
        else{
            ivQr.image = nil
            qrcodeImage = nil
        }
        
        //firebase'e ekleme
        addToFirebase()
        
    }
    
    func displayQRCodeImage() {
        let scaleX = ivQr.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = ivQr.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        let image = UIImage(ciImage: transformedImage)
        
        ivQr.contentMode = .scaleAspectFit
        ivQr.image = image;
    }
    
    func addToFirebase()
    {
        
        let post:[String : AnyObject] = [
            "old_price": self.display.product_price_old as AnyObject,
            "product":self.display.product as AnyObject,
            "sale_rate":self.display.sale_rate as AnyObject,
            "time":"26-05-2017" as AnyObject
        ]
        self.ref.child("shopping").child(UserDefaults.standard.string(forKey: userIdKey)!).childByAutoId().setValue(post)
    }
    
    
    
    
    func openMapForPlace() {
        
        let latitude: CLLocationDegrees = 37.2
        let longitude: CLLocationDegrees = 22.9
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Place Name"
        mapItem.openInMaps(launchOptions: options)
    }
}
