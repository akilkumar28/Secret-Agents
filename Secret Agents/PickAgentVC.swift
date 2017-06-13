//
//  PickAgentVC.swift
//  Secret Agents
//
//  Created by AKIL KUMAR THOTA on 6/13/17.
//  Copyright © 2017 Akil Kumar Thota. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PickAgentVC: UIViewController ,MKMapViewDelegate,CLLocationManagerDelegate{

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let Mlocation = locations[0]
        
        let latitude = Mlocation.coordinate.latitude
        let longitude = Mlocation.coordinate.longitude
        
        
        let latdelta:CLLocationDegrees = 0.5
        let londelta:CLLocationDegrees = 0.5
        
        let span = MKCoordinateSpan(latitudeDelta: latdelta, longitudeDelta: londelta)
        
        let centre  = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let mapregion = MKCoordinateRegion(center: centre, span: span)
        
        self.map.setRegion(mapregion, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = centre
        map.addAnnotation(annotation)
        
    }
    
    


}
