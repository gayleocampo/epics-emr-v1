//
//  InventoryTablesViewController.swift
//  emr-prototype-v1
//
//  Created by Gayle Ocampo on 11/8/15.
//  Copyright © 2015 Gayle Ocampo. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class InventoryTableViewController: PFQueryTableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //initialize the PFQueryTableView
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        //configure the PFQueryTableView
        self.parseClassName = "Medication_Inventory"
        self.textKey = "medicationName"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    //define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Medication_Inventory")
        
        // Add a where clause if there is a search criteria
        if searchBar.text != "" {
            query.whereKey("searchText", containsString: searchBar.text!.lowercaseString)
        }
        
        let lowercaseMedication = "medicationName".lowercaseString
        query.orderByAscending(lowercaseMedication)
        
        return query
    }
    
    override func viewDidAppear(animated: Bool) {
        //data reloading from parse
        self.loadObjects()
        
        searchBar!.delegate = self
        
        //activate and display the edit button
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        //create a cell
        var cell = tableView.dequeueReusableCellWithIdentifier("medicationCell") as! PFTableViewCell!
        
        //ensure the cell exists -- Parse recommends that
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "medicationCell")
        }
        
        //extract values from the PFObject to dispaly in the table view
        if let medication = object!["medicationName"] as? String {
            cell?.textLabel?.text = medication
        }
        
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            //get current object from the parse table
            let currentMedication: PFObject = objects![indexPath.row] as! PFObject
            
            //delete object in background without blockng the app resuming
            currentMedication.deleteInBackground()
            
            //reload from server
            self.loadObjects();
            
        }
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
        // Dismiss the keyboard
        searchBar.resignFirstResponder()
        
        // Force reload of table data
        self.loadObjects()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        // Dismiss the keyboard
        searchBar.resignFirstResponder()
        
        // Force reload of table data
        self.loadObjects()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        // Clear any search criteria
        searchBar.text = ""
        
        // Dismiss the keyboard
        searchBar.resignFirstResponder()
        
        // Force reload of table data
        self.loadObjects()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let detailedVC = segue.destinationViewController as? MedicationDetailViewController, let indexPath = self.tableView.indexPathForSelectedRow {
            
            if segue.identifier == "segueToMedicationDetail" {
                
                detailedVC.currentObject = objects![indexPath.row] as? PFObject
            }
        }
    }


}
