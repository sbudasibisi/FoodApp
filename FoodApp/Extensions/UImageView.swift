
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func setImage(url: String){
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.reloadImage(data: data)
                
            }
        }
    }
    
    func reloadImage(data: NSData){
        DispatchQueue.main.async() {
            self.image = UIImage(data: data as Data)
        }
    }
}
