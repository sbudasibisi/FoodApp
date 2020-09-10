
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class Restaurent: NSObject , MKAnnotation{
    var title:  String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var imageURL: String?
    var image: UIImage?
    var imageLoaderDelegate: ServicesProtocol?
    
    init(restaurentName: String, distance: String, destinationLoction: CLLocation, imageUrl: String?) {
        self.title = restaurentName
        self.subtitle = distance
        self.imageURL = imageUrl
        self.coordinate = CLLocationCoordinate2D(latitude: destinationLoction.coordinate.latitude, longitude: destinationLoction.coordinate.longitude)
        super.init()
        if(imageUrl != nil){
            DispatchQueue.global().async {
                self.setNewImage(url: imageUrl!)
            }
        }
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
    
    
    func setNewImage(url: String){
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                    self.image = UIImage(data: data as Data)
                    self.imageLoaderDelegate?.updateTable()
                
            }
        }
    }
    
}
