//
//  AddressSearchViewController.swift
//
//  Created by You on 13/09/16.
//  Copyright © 2016 Jürgen Punz. All rights reserved.
//

import UIKit

class AddressSearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var autoCompletion : AutoCompletion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 9.3, *) {
            autoCompletion = MapKitAutoCompletion(viewController: self, tableView: tableView)
        } else {
            autoCompletion = PlacesAutoCompletion(viewController: self, tableView: tableView)
        }
        
        tableView.delegate = autoCompletion
        tableView.dataSource = autoCompletion
    }
    
    
    // MARK: SearchBarDelegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty
        {
            autoCompletion!.query(searchText)
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }

}
