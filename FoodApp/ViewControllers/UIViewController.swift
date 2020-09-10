
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit

extension UIViewController{
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiateFromStoryBoard(appStoryBoard: AppStoryBoards)->Self{
        return appStoryBoard.viewController(viewControllerClass: self)
    }
}


enum AppStoryBoards: String {
    case Main
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type)->T{
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyBoardID) as! T
    }
    
    func initialViewController()->UIViewController?{
        return instance.instantiateInitialViewController()
    }
}
