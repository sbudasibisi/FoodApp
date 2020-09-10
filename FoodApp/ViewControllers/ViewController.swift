
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, ServicesProtocol, UISearchBarDelegate, MKMapViewDelegate, LocationProtocol {
    
    var currentLocation: CLLocation?
   
    
    var restaurents = [Restaurent]()
    var restaurentsViewModel = RestaurentsViewModel()
    
    @IBOutlet weak var restaurantSearchBar: UISearchBar!
    @IBOutlet weak var restaurentsTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        restaurantSearchBar.delegate = self
        restaurentsViewModel.serviceDelegate = self
    }
    
    
    func configureTableView(){
        restaurentsTableView.delegate = self
        restaurentsTableView.dataSource = self
        restaurentsTableView.register(RestaurentTableViewCell.nib(), forCellReuseIdentifier: RestaurentTableViewCell.cellIdentifier)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = restaurents.count
        return number
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurentTableViewCell.cellIdentifier, for: indexPath) as! RestaurentTableViewCell
        let restaurent = restaurents[indexPath.row]
        cell.configureCellData(name: restaurent.title!, distance: restaurent.subtitle!, image: UIImage())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        destinationLocationPressed(destination: restaurents[indexPath.row])
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else {
            return
        }
        self.restaurentsViewModel.retrieveSearchResults(search: keyword.replaceCharacter(" ", by:"-"))
        self.view.endEditing(true)
    }
    
    
    func locationUpdated(latitude: Double, longitude: Double) {
        self.currentLocation = CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func errorUpdatingLocation(title: String, description: String) {
        
    }
    
    func updateRestaurents(restaurents: [Restaurent]) {
        self.restaurents = restaurents
        DispatchQueue.main.async {
            self.restaurentsTableView.reloadData()
        }
    }
    
    func error_response(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle:.alert)
               alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (action) in
        }))
        self.present(alert, animated: true , completion: nil)
    }
    
    
    func destinationLocationPressed(destination: Restaurent){
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let viewMapAction = UIAlertAction(title: "View on a map", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let mapViewController = MapViewController.instantiateFromStoryBoard(appStoryBoard: .Main)
            mapViewController.currentLocation = self.currentLocation
            mapViewController.destinationLocation = destination
            self.present(mapViewController, animated: true, completion: nil)
        })
        
        let iCloudAction = UIAlertAction(title: "Save to iCloud", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(viewMapAction)
        optionMenu.addAction(iCloudAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}

