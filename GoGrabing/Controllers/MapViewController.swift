//
//  MapViewController.swift
//  GoGrabing
//
//  Created by Darshan on 2020-04-17.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        latitudeLabel.text = "Latitude : \(locValue.latitude)"
        longitudeLabel.text = "Longitude :\(locValue.longitude)"
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
}
