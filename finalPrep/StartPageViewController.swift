//
//  StartPageViewController.swift
//  finalPrep
//
//  Created by Adem Hadrovic on 6/10/18.
//  Copyright © 2018 SSST. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class StartPageViewController: UIViewController {

    //TO DO: write login logic
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var invalidCredPromptlLabel: UILabel!
    
    @IBAction func loginUser(_ sender: Any) {
        
        invalidCredPromptlLabel.isHidden = true
        let loginParams = [
            
            "email":emailInput.text!,
            "pass":passwordInput.text!
            
            ] as [String:Any]
        
        Alamofire.request("https://emalocalserver.herokuapp.com/login", method: .post,parameters:loginParams,encoding:JSONEncoding.default,headers:nil).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if(json["status"] == "valid"){
                        self.performSegue(withIdentifier: "goToMain", sender: "Any")
                    }
                    else{
                        self.invalidCredPromptlLabel.isHidden = false
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        invalidCredPromptlLabel.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
