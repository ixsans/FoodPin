//
//  RestaurantDetailViewCellTableViewCell.swift
//  FoodPin
//
//  Created by Ikhsan on 29/8/17.
//  Copyright © 2017 Ikhsan. All rights reserved.
//

import UIKit

class RestaurantDetailViewCellTableViewCell: UITableViewCell {
    
    @IBOutlet var fieldLabelView:UILabel!
    @IBOutlet var valueLabelView:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
