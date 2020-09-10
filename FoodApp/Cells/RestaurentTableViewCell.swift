
//  Copyright © 2020 Sibusiso. All rights reserved.
//

import UIKit

class RestaurentTableViewCell: UITableViewCell {

    static let cellIdentifier = "RestaurentTableViewCell"
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var restaurentImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCellData(name: String , distance: String, image: UIImage?)
    {
        self.name.text = name
        self.distance.text = distance
        if (image != nil){
            self.restaurentImageView.image = image!
        }
        
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName: "RestaurentTableViewCell", bundle: nil)
    }
}
