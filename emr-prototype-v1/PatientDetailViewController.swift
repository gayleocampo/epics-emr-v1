//
//  PatientDetailViewController.swift
//  emr-prototype-v1
//
//  Created by Gayle Ocampo on 11/8/15.
//  Copyright © 2015 Gayle Ocampo. All rights reserved.
//

import UIKit
import Parse

class PatientDetailViewController: UIViewController {

    @IBOutlet weak var patientImage: UIImageView!
    @IBOutlet weak var patientName: UITextField!
    @IBOutlet weak var patientDOB: UITextField!
    @IBOutlet weak var patientAge: UITextField!
    @IBOutlet weak var patientGender: UITextField!
    @IBOutlet weak var patientHeight: UITextField!
    @IBOutlet weak var patientWeight: UITextField!
    @IBOutlet weak var patientAllergies: UITextView!
    
    var currentObject: PFObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentPatient = currentObject {
            patientImage.image = UIImage(named:(currentPatient["patientImage"] as? String)!)
            patientName.text = currentPatient["patientFullName"] as? String
            patientDOB.text = currentPatient["patientDOB"] as? String
            patientAge.text = currentPatient["patientAge"] as? String
            patientGender.text = currentPatient["patientGender"] as? String
            patientHeight.text = currentPatient["patientHeight"] as? String
            patientWeight.text = currentPatient["patientWeight"] as? String
            patientAllergies.text = currentPatient["patientAllergies"] as? String
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
