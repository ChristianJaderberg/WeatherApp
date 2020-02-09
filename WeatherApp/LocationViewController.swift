//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by Christian Jäderberg on 2020-02-06.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    var location = Location(title: "LocationName")
    
    @IBOutlet weak var locationNavigation: UINavigationItem!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationNavigation.title = self.location.title
        locationLabel.text = self.location.title
    }
}
