//
//  MedicationDetailViewController.swift
//  emr-prototype-v1
//
//  Created by Gayle Ocampo on 11/8/15.
//  Copyright © 2015 Gayle Ocampo. All rights reserved.
//

import UIKit
import Parse

class MedicationDetailViewController: UIViewController {
    
    @IBOutlet weak var medicationName: UITextField!
    @IBOutlet weak var medicationQuantity: UITextField!
    @IBOutlet weak var medicationNotes: UITextView!
    
    var currentObject: PFObject?
    
    @IBAction func saveMedication(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentMedication = currentObject {
            medicationName.text = currentMedication["medicationName"] as? String
            medicationQuantity.text = currentMedication["medicationQuantity"] as? String
            medicationNotes.text = currentMedication["medicationNotes"] as? String
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}
