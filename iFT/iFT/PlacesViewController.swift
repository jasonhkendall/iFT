//
//  PlacesViewController.swift
//  iFT
//
//  Created by Jason Howard Kendall on 5/24/19.
//  Copyright © 2019 JHK. All rights reserved.
//

import UIKit
import GooglePlaces

class PlacesViewController: UIViewController, UITextFieldDelegate, GMSAutocompleteFetcherDelegate {
  @IBOutlet weak var textFieldSearchPlaces: UITextField!
  @IBOutlet weak var tableView: UITableView!

  // An array to hold the list of possible locations.
  var likelyPlaces: [GMSPlace] = []
  var selectedPlace: GMSPlace?

  // Cell reuse id (cells that scroll out of view can be reused).
  let cellReuseIdentifier = "cell"
    
    
    var fetcher: GMSAutocompleteFetcher?
    var fetcherResults: [GMSAutocompletePrediction] = []

    

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Register the table view cell class and its reuse id.
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    
    // This view controller provides delegate methods and row data for the table view.
    tableView.delegate = self
    tableView.dataSource = self
    
    let filter = GMSAutocompleteFilter()
    filter.type = .noFilter
    
    // Create the fetcher.
    fetcher = GMSAutocompleteFetcher(bounds: nil, filter: filter)
    
    fetcher?.delegate = self
    
    tableView.reloadData()
    }

    // This function is called whenever textfield's text is changed
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let searchText = textField.text {
            fetcher?.sourceTextHasChanged(searchText)
        }
        return true
    }
    
    // This function is called whenever user press return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text)
        self.view.endEditing(true)
        if let searchText = textField.text {
            fetcher?.sourceTextHasChanged(searchText)
        }
        return true
    }
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        print(predictions)
        self.fetcherResults.removeAll()
        for predition in predictions {
            print(predition)
            fetcherResults.append(predition)
        }
        self.tableView.reloadData()
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    
    // Pass the selected place to the new view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToMain" {
            if let nextViewController = segue.destination as? MapViewController {
                nextViewController.selectedPlace = selectedPlace
            }
        }
    }
}

// Respond when a user selects a place.
extension PlacesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if fetcherResults.count < 1 {
            selectedPlace = likelyPlaces[indexPath.row]
            performSegue(withIdentifier: "unwindToMain", sender: self)
        } else {
            GMSPlacesClient.shared().lookUpPlaceID(fetcherResults[indexPath.row].placeID) { (place, error) in
                if let err = error {
                    //error is not nill
                    print(err.localizedDescription)
                } else {
                    print(place)
                }
            }
        }
    }
}

// Populate the table with the list of most likely places.
extension PlacesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fetcherResults.count < 1 {
            return likelyPlaces.count
        } else {
            return fetcherResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let collectionItem = likelyPlaces[indexPath.row]
        
        if fetcherResults.count < 1 {
            cell.textLabel?.text = collectionItem.name
        } else {
            cell.textLabel?.text = fetcherResults[indexPath.row].attributedPrimaryText.string
        }
        
        return cell
    }
    
    // Adjust cell height to only show the first five items in the table
    // (scrolling is disabled in IB).
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.frame.size.height/5
    }
    
    // Make table rows display at proper height if there are less than 5 items.
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if (section == tableView.numberOfSections - 1) {
            return 1
        }
        return 0
    }
}
