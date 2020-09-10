
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit

protocol LocationProtocol {
    func locationUpdated(latitude: Double, longitude: Double)
    func errorUpdatingLocation(title: String, description: String)
}
