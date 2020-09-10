//
//  RestaurentsViewModel.swift
//  FoodApp
//
//  Created by Sibusiso on 2020/09/09.
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit
import CoreLocation

class RestaurentsViewModel: NSObject, LocationProtocol {
    
    var currentLocation: CLLocation?
    var serviceDelegate: ServicesProtocol?
    let restaurentsService: RestaurentsService!
    
    override init() {
        self.restaurentsService = RestaurentsService()
        super.init()
        LocationManager.shared.locationProtocol = self
    }
    
    
    func retrieveSearchResults(search: String){
        guard let latitude = currentLocation?.coordinate.latitude, let longitude = currentLocation?.coordinate.longitude else{
            serviceDelegate?.error_response(title: "Location Error", message: "Unable to retrieve current location.")
            return
        }
        self.restaurentsService.retrieveNearbyRestaurents(keywordSearch: search, latitude: latitude, longitude: longitude, completion: handleSearchResults)
    }
    
    
    func handleSearchResults(restaurents: [Results]?, error: Error?){
        if restaurents != nil{
            var restaurentItems = [Restaurent]()
            for result in restaurents!{
                let destinationLocation = CLLocation(latitude: (result.geometry?.location?.lat)!, longitude: (result.geometry?.location?.lng)!)
                let distance = calculateDistance(currentLocation: currentLocation, destinationLoction: destinationLocation)
                
                if let photoReference = result.photos?[0].photo_reference{
                    let url = "https://maps.googleapis.com/maps/api/place/photo?maxheight=200&photoreference="+photoReference+"&key="+API_KEY
                    let restaurentItem = Restaurent(restaurentName: result.name!, distance: distance, destinationLoction: destinationLocation,imageUrl: url)
                    restaurentItems.append(restaurentItem)
                } else{
                    let restaurentItem = Restaurent(restaurentName: result.name!, distance: distance, destinationLoction: destinationLocation,imageUrl: nil)
                    restaurentItems.append(restaurentItem)
                }
            }
            self.serviceDelegate?.updateRestaurents(restaurents: restaurentItems)
        }else{
            if error != nil{
                serviceDelegate?.error_response(title: "Error encountered" , message: error!.localizedDescription)
            }else{
                serviceDelegate?.error_response(title: "Error encountered" , message: "Unknown error encountered.")
            }
        }
    }
    
    
    func calculateDistance(currentLocation: CLLocation?, destinationLoction: CLLocation)->String{
        let distance = currentLocation!.distance(from: destinationLoction)*0.001
        return String(format: "%.2f", distance)+" KM"

    }
    
    
    func locationUpdated(latitude: Double, longitude: Double) {
        self.currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        
    }
    
    func errorUpdatingLocation(title: String, description: String) {
        serviceDelegate?.error_response(title: "Location Error", message: "Unable to retrieve current location.")
    }
}
