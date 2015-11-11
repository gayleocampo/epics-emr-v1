//
//  CheckInTriageTableViewController.swift
//  emr-prototype-v1
//
//  Created by Gayle Ocampo on 11/11/15.
//  Copyright © 2015 Gayle Ocampo. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class CheckInTriageTableViewController: PFQueryTableViewController {

    //initialize the PFQueryTableView
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        //configure the PFQueryTableView
        self.parseClassName = "Patients"
        self.textKey = "patientFullName"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
    }
    
    //define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Patients")
        query.orderByAscending("patientFullName")
        
        return query
    }
    
    override func viewDidAppear(animated: Bool) {
        //data reloading from parse
        self.loadObjects()
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        //create a cell
        var cell = tableView.dequeueReusableCellWithIdentifier("patientCell") as! PFTableViewCell!
        
        //ensure the cell exists -- Parse recommends that
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "patientCell")
        }
        
        //extract values from the PFObject to dispaly in the table view
        if let patient = object!["patientFullName"] as? String {
            cell?.textLabel?.text = patient
            
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let detailedVC = segue.destinationViewController as? PatientDetailViewController, let indexPath = self.tableView.indexPathForSelectedRow {
            
            if segue.identifier == "segueToPatientDetail" {
                
                detailedVC.currentObject = objects![indexPath.row] as? PFObject
            }
        }
    }

}
