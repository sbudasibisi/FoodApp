
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , MKMapViewDelegate, MapUpdatesProtiocol{
    
    
    
    var mapViewModel: MapViewModel!
    var currentLocation: CLLocation?
    var destinationLocation: Restaurent?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapViewModel = MapViewModel()
        mapViewModel.mapUpdatesDelegate = self
        updateCurrentLocation()
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Restaurent else{
            return nil
        }
        var view: MKMarkerAnnotationView
        let identifier = "restaurentIdentifier"
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
            dequeuedView.annotation = annotation
            view = dequeuedView
        }else{
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: 0, y: 0)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let restaurent = view.annotation as? Restaurent else {
            return
        }
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        restaurent.mapItem?.openInMaps(launchOptions: launchOptions)
    }
    
    
    func centerCurrentLocation(location :CLLocation, radius: CLLocationDistance){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func updateCurrentLocation() {
        centerCurrentLocation(location: mapViewModel.currentLocation!, radius: 1000)
        mapView.setRegion(mapViewModel.region, animated: true)
        mapView.addAnnotation(destinationLocation!)
        mapView.showsUserLocation = true
    }
    
    func error_response(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle:.alert)
               alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action) in
               self.present(alert, animated: true , completion: nil)
        }))
    }
}
