//
//  ViewController.swift
//  WeatherApp
//
//  Created by Christian Jäderberg on 2020-02-03.
//  Copyright © 2020 Christian Jäderberg. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var testArray = ["Gothenburg", "Stockholm", "San Diego", "Åmål", "Vänersborg", "Umeå", "Malmö"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // code needed for hiding keyboard when enter is pressed
        self.searchTextField.delegate = self
    }
    
    // hide keyboard when enter is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.locationNameLabel.text = testArray[indexPath.row]
        return cell
    }
    
    // row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // remove grey selection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "locationSegue",
            let destinationVC = segue.destination as? LocationViewController,
            let locationIndex = tableView.indexPathForSelectedRow?.row
        {
            destinationVC.location = testArray[locationIndex]
        }
    }
 
    

}

