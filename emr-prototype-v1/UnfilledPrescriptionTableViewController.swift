//
//  UnfilledPrescriptionTableViewController.swift
//  emr-prototype-v1
//
//  Created by Gayle Ocampo on 11/9/15.
//  Copyright © 2015 Gayle Ocampo. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class UnfilledPrescriptionTableViewController: PFQueryTableViewController {

    //initialize the PFQueryTableView
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        //configure the PFQueryTableView
        self.parseClassName = "Prescriptions"
        self.textKey = "patientName"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    //define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Prescriptions")
        query.orderByAscending("patientName")
        query.whereKey("prescriptionFilled", equalTo: false)
        
        return query
    }
    
    override func viewDidAppear(animated: Bool) {
        //data reloading from parse
        self.loadObjects()
        
        self.navigationController!.navigationBar.translucent = false;
        
        //activate and display the edit button
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        //create a cell
        var cell = tableView.dequeueReusableCellWithIdentifier("prescriptionCell") as! PFTableViewCell!
        
        //ensure the cell exists -- Parse recommends that
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "prescriptionCell")
        }
        
        //extract values from the PFObject to dispaly in the table view
        if let patient = object!["patientName"] as? String {
            cell?.textLabel?.text = patient
            cell?.detailTextLabel?.text = object!["medicationName"] as? String
            
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            //get current object from the parse table
            let currentPatient: PFObject = objects![indexPath.row] as! PFObject
            
            //delete object in background without blockng the app resuming
            currentPatient.deleteInBackground()
            
            //reload from server
            self.loadObjects();
            
        }
    }

}
