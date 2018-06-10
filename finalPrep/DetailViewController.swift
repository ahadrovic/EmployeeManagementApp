//
//  DetailViewController.swift
//  finalPrep
//
//  Created by Adem Hadrovic on 6/8/18.
//  Copyright © 2018 SSST. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

   
   
    @IBOutlet weak var fnameLabel: UILabel!
    
    @IBOutlet var lnameLabel: UILabel!
    
    @IBOutlet weak var dobLabel: UILabel!
    
    @IBOutlet weak var hasLicenseLabel: UILabel!
    
    @IBOutlet weak var positionLabel: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        if let detail = detailEmployee {
            if let label = fnameLabel {
                label.text = detail.fname
                
            }
            if let label = lnameLabel {
                label.text = detail.lname
                
            }
            if let label = dobLabel {
                label.text = detail.dob
            }
            if let label = hasLicenseLabel {
                label.text = detail.hasDrivingLicense
            }
            if let label = positionLabel {
                label.text = detail.position
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailEmployee: Employee? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

