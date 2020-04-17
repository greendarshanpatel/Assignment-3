//
//  ItemTableViewCell.swift
//  GoGrabing
//
//  Created by Darshan Patel on 2020-03-23.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var StoreImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCost: UILabel!
    @IBOutlet weak var customView: UIView!
    var cellItem : Item!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
