//
//  MapKitAutoCompletion.swift
//
//  Created by You on 13/09/16.
//  Copyright © 2016 Jürgen Punz. All rights reserved.
//

import UIKit
import MapKit

@available(iOS 9.3, *)
class MapKitAutoCompletion: NSObject, AutoCompletion, MKLocalSearchCompleterDelegate {
    var searchResults = [MKLocalSearchCompletion]()
    var searchCompleter = MKLocalSearchCompleter()
    let tableView : UITableView
    let viewController : UIViewController
    var searchLocation : CLLocation?
    
    required init(viewController : UIViewController, tableView : UITableView)
    {
        self.tableView = tableView
        self.viewController = viewController
        
        super.init()
        
        searchCompleter.delegate = self
    }
    
    func query(searchText : String)
    {
        searchCompleter.queryFragment = searchText
    }
    
    func setDestinationViewControllerData(destinationViewController : ResultsViewController)
    {
        destinationViewController.searchLocation = searchLocation
    }
    
    // MARK: CompleterDelegate
    func completerDidUpdateResults(completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }
    
    // MARK: TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let request = MKLocalSearchRequest(completion: searchResults[indexPath.row])
        
        MKLocalSearch(request: request).startWithCompletionHandler {
            (response, error) -> Void in
            
            if response == nil{
                return
            }
            
            self.searchLocation = response?.mapItems.first?.placemark.location
            // Do something e.g. Segue!
        }
    }
}
