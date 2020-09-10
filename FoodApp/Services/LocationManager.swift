
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var currentLocation: CLLocation?
    var locationProtocol: LocationProtocol?
    let locationManager = CLLocationManager()
    
    static let shared = LocationManager()

    private override init() {
        super.init()
        configureLocationManager()
    }
    
    func configureLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            configureLocationManager()
        default:
            locationManager.startUpdatingLocation()
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty{
            locationManager.stopUpdatingLocation()
            guard let firstLocationItem = locations.first else {
                locationProtocol?.errorUpdatingLocation(title: "Location update", description: "Unable to get user location")
                return
            }
            currentLocation = firstLocationItem
            locationProtocol?.locationUpdated(latitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!)
            
        }
    }

}
