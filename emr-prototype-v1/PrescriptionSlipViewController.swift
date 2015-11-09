//
//  PrescriptionSlipViewController.swift
//  emr-prototype-v1
//
//  Created by Gayle Ocampo on 11/9/15.
//  Copyright © 2015 Gayle Ocampo. All rights reserved.
//

import UIKit
import Parse

class PrescriptionSlipViewController: UIViewController {
    @IBOutlet weak var patientName: UITextField!
    @IBOutlet weak var medicationName: UITextField!
    @IBOutlet weak var medicationAmount: UITextField!
    @IBOutlet weak var physicianName: UITextField!
    
    var currentObject: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let currentPrescription = currentObject {
            patientName.text = currentPrescription["patientName"] as? String
            medicationName.text = currentPrescription["medicationName"] as? String
            medicationAmount.text = currentPrescription["medicationAmount"] as? String
            physicianName.text = currentPrescription["physicianName"] as? String
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
