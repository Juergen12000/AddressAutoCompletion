//
//  PlacesAutoCompletion.swift
//
//  Created by You on 13/09/16.
//  Copyright © 2016 Jürgen Punz. All rights reserved.
//

import UIKit
import HNKGooglePlacesAutocomplete

class PlacesAutoCompletion: NSObject, AutoCompletion {
    let searchQuery : HNKGooglePlacesAutocompleteQuery = HNKGooglePlacesAutocompleteQuery.sharedQuery()
    var searchResults : [HNKGooglePlacesAutocompletePlace] = []
    
    let tableView : UITableView
    let viewController : UIViewController
    var prevSearchText: String = ""
    var searchLocation : CLLocation?
    
    required init(viewController: UIViewController, tableView: UITableView) {
        self.tableView = tableView
        self.viewController = viewController
    }
    
    func query(searchText: String) {       
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(PlacesAutoCompletion.sendQuery), object: prevSearchText)
        self.performSelector(#selector(PlacesAutoCompletion.sendQuery), withObject: searchText, afterDelay: 1)
    }
    
    func sendQuery(searchText : String)
    {
        searchQuery.fetchPlacesForSearchQuery(searchText, completion: {(places : [AnyObject]!, error : NSError!) in
            if let err = error
            {
                NSLog("Error'd: \(err)")
            }
            else
            {
                self.searchResults = places as! [HNKGooglePlacesAutocompletePlace]
                self.tableView.reloadData()
            }
        })
    }
    
    func setDestinationViewControllerData(destinationViewController : ResultsViewController)
    {
        destinationViewController.searchLocation = searchLocation
    }

    // MARK: TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        
        cell.textLabel?.text = self.searchResults[indexPath.row].name        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        CLPlacemark.hnk_placemarkFromGooglePlace(searchResults[indexPath.row], apiKey: searchQuery.apiKey, completion: {(placemark: CLPlacemark!, addressString: String!, error: NSError!) in
            
            if let pm = placemark
            {
                self.searchLocation = pm.location
                // Do something e.g. Segue!
            }
        })
    }
}
