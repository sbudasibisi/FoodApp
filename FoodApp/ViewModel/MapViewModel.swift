
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewModel: NSObject, LocationProtocol {
    
    var currentLocation: CLLocation?
    var mapUpdatesDelegate: MapUpdatesProtiocol?
    
    override init() {
       super.init()
        LocationManager.shared.locationProtocol = self
        currentLocation = LocationManager.shared.currentLocation
    }
    
    func locationUpdated(latitude: Double, longitude: Double) {
        self.currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        mapUpdatesDelegate?.updateCurrentLocation()
    }
    
    func errorUpdatingLocation(title: String, description: String) {
        mapUpdatesDelegate?.error_response(title: "Location Error", message: "Unable to retrieve current location.")
    }
    
    
    var region: MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        return region
    }

}
