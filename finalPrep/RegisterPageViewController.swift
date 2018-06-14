//
//  RegisterPageViewController.swift
//  finalPrep
//
//  Created by Adem Hadrovic on 6/10/18.
//  Copyright © 2018 SSST. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterPageViewController: UIViewController {

    //TO DO: write register user logic
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmPassInput: UITextField!
    
    @IBOutlet weak var userExistsPrompt: UILabel!
    @IBOutlet weak var noMatchPrompt: UILabel!
    @IBOutlet weak var serverErrorPrompt: UILabel!
    @IBOutlet weak var needEmailPrompt: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        serverErrorPrompt.isHidden = true
        noMatchPrompt.isHidden = true
        userExistsPrompt.isHidden = true
        needEmailPrompt.isHidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerUser(_ sender: Any){
        
        serverErrorPrompt.isHidden = true
        noMatchPrompt.isHidden = true
        userExistsPrompt.isHidden = true
        needEmailPrompt.isHidden = true
        
        let registerParams = [
            
            "email":emailInput.text!,
            "pass":passwordInput.text!
            
            ] as [String:Any]
        
        //user should be test2@ssst.ba and password should be pass2
        
        if(emailInput.text!.isEmpty){
            
            needEmailPrompt.isHidden = false
            
        }
        
        
        if(passwordInput.text! == confirmPassInput.text!){
            
            Alamofire.request("https://emalocalserver.herokuapp.com/register", method: .post,parameters:registerParams,encoding:JSONEncoding.default,headers:nil).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if(json["status"] == "valid"){
                        self.performSegue(withIdentifier: "goToLogin", sender: "Any")
                    }
                    else{
                        self.userExistsPrompt.isHidden = false
                    }
                    
                case .failure(let error):
                    
                    self.serverErrorPrompt.isHidden = true
                    print(error)
                }
            }
            
        }
        else{
            noMatchPrompt.isHidden = false
        }
        
        
       
        
        
        
    }

}
