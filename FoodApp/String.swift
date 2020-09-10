//
//  String.swift
//  FoodApp
//
//  Created by Sibusiso on 2020/09/10.
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit

extension String {
    func replaceCharacter(_ oldChar: String, by newChar: String) -> String {
        let newStr = self.replacingOccurrences(of: oldChar, with: newChar, options: .literal, range: nil)
        return newStr
    }
}
