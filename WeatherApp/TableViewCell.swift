//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by Christian Jäderberg on 2020-02-06.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var locationNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
