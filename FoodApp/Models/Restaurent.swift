
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class Restaurent: NSObject , MKAnnotation{
    var title:  String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var image: UIImageView?
    
    
    init(restaurentName: String, distance: String, destinationLoction: CLLocation, imageUrl: String?) {
        self.title = restaurentName
        self.subtitle = distance
//        if(imageUrl != nil){
//            self.image = UIImageView()
//            self.image?.setImage(url: imageUrl!)
//        }
        self.coordinate = CLLocationCoordinate2D(latitude: destinationLoction.coordinate.latitude, longitude: destinationLoction.coordinate.longitude)
        super.init()
    }
   
    
    var mapItem: MKMapItem? {
        guard let location = title else{
            return nil
        }
        
        let addressDictionary = [CNPostalAddressStreetKey: location]
        let placemark = MKPlacemark(coordinate:coordinate , addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    
}
