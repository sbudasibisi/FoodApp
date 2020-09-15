
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
    
    
    
    func retrieveDirections(mapView: MKMapView, destinationLocation: Restaurent){
    let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.currentLocation!.coordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation.coordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile

        let directions = MKDirections(request: request)

        directions.calculate {response, error in
            guard let unwrappedResponse = response else { return }

            for route in unwrappedResponse.routes {
                mapView.addOverlay(route.polyline)
                mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
}
