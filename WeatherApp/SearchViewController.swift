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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var searchResultArray = [Location]()
    let api = API()
    
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
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        // check if textfield is empty, if it is show alert, otherwise call the search-method with the textfield-value
        if (searchTextField.text != "") {
            let searchString : String = searchTextField.text!
            searchLocation(searchString:searchString)
            
            // hide keyboard
            searchTextField.resignFirstResponder()
            
            // clear textfield
            self.searchTextField.text = ""
        } else {
            // create and show alert message
            let alert : UIAlertController = UIAlertController(title: "No input", message: "Please enter something to search for", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func searchLocation(searchString: String) -> Void {
        print("searchLocation-Method called")
        // TODO progress indicator start
        self.activityIndicator.startAnimating()
        api.searchLocation(searchString: searchString) { (result) in
            switch result {
            case .success(let locationArray):
                let resultArray: [Location] = locationArray
                if (!resultArray.isEmpty) {
                    self.searchResultArray = resultArray
                    for i in resultArray {
                        print("Value: " + i.title + ", woeid: " + String(i.woeid))
                    }
                } else {
                    self.searchResultArray.removeAll()
                    // TODO To tell that no location was found, use Alert view instead of a tableview row
                    let location = Location()
                    self.searchResultArray.append(location)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    // TODO progress indicator stop
                    self.activityIndicator.stopAnimating()
                }
            case .failure(let error): print("Error \(error)")
            }
        }
    }
    
    // MARK: - Tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.locationNameLabel.text = self.searchResultArray[indexPath.row].title
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
            destinationVC.location = searchResultArray[locationIndex]
        }
    }
 
    

}

