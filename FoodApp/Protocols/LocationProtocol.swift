//
//  LocationProtocol.swift
//  FoodApp
//
//  Created by Sibusiso on 2020/09/10.
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit

protocol LocationProtocol {
    func locationUpdated(latitude: Double, longitude: Double)
    func errorUpdatingLocation(title: String, description: String)
}
