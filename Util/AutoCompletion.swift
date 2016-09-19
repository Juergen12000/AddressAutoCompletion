//
//  AutoCompletion.swift
//
//  Created by You on 13/09/16.
//  Copyright © 2016 Jürgen Punz. All rights reserved.
//

import UIKit

protocol AutoCompletion: NSObjectProtocol, UITableViewDelegate, UITableViewDataSource {
    init(viewController : UIViewController, tableView : UITableView)
    
    func query(searchText : String)
    func setDestinationViewControllerData(destinationViewController : ResultsViewController)
    
    // MARK: UITableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
}
