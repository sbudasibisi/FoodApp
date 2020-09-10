//
//  ServicesProtocol.swift
//  FoodApp
//
//  Created by Sibusiso on 2020/09/09.
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit

    protocol ServicesProtocol {
        func updateRestaurents(restaurents: [Restaurent])
        func error_response(title: String, message: String)

    }

