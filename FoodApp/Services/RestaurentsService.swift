
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit

let API_KEY = "API_KEY"

class RestaurentsService: NSObject {

  
    func retrieveNearbyRestaurents(keywordSearch: String, latitude: Double, longitude: Double, completion: @escaping ([Results]?, Error?) ->()){
        let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
        let location = "location="+String(latitude)+","+String(longitude)
        let searchParameters = "&radius=1500&type=restaurant&keyword="+keywordSearch+"&key="+API_KEY
        let connectionURL = url+location+searchParameters
        
        if let url = NSURL(string: connectionURL){
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration).dataTask(with: url as URL, completionHandler: {(data, response, error) in
                if let restaurentsResponse = try? JSONDecoder().decode(Json4Swift_Base.self, from: data!){
                   completion(restaurentsResponse.results!, nil)
                   print(String(data: data!, encoding: String.Encoding.utf8)!)
                }else{
                    if let error = error{
                        completion(nil, error)                    }
                }
             })
            session.resume()
        }
    }
    
}
