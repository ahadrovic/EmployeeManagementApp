//
//  CreateEmployeeViewController.swift
//  finalPrep
//
//  Created by Adem Hadrovic on 6/8/18.
//  Copyright © 2018 SSST. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Darwin



class CreateEmployeeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    
    
    
    
    //will need to add addEmployee method here
    @IBOutlet weak var fnameInput: UITextField!
    
    @IBOutlet weak var lnameInput: UITextField!
    
    @IBOutlet weak var positionInput: UITextField!
    
    
    @IBOutlet weak var yesNoPicker: UIPickerView!
    
    var pickerData:[String] = [String]()
    
    
    @IBOutlet weak var dobInput: UIDatePicker!
    
    
    
    @IBOutlet weak var doneButton: UIButton!
    
    
    var changedDate:Bool = false
    var selectedYesOrNo = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.yesNoPicker.dataSource = self
        self.yesNoPicker.delegate = self
        
        //need delegates for the text inputs so the keyboard can hide
        self.fnameInput.delegate = self
        self.lnameInput.delegate = self
        self.positionInput.delegate = self
        
        pickerData = ["Yes","No"]
        
        doneButton.isEnabled = false
        fnameInput.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        lnameInput.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        positionInput.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        
        dobInput.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    //close keyboard on tap on touch screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //close keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }
    
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        
        guard
            let fname = fnameInput.text, !fname.isEmpty,
            let lname = lnameInput.text, !lname.isEmpty,
            let position = positionInput.text, !position.isEmpty
            //changedDate,
            //selectedYesOrNo
            
            else {
                self.doneButton.isEnabled = false
                return
        }
        doneButton.isEnabled = true
    }
    
    @objc func dateChanged(_ datePicker: UIDatePicker){
        changedDate = true
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedYesOrNo = true
    }
    
    
    @IBAction func saveNewEmployee(_ sender: Any) {
        
        //simple random number generator for ID. There is definitely a better way, but I was too lazy
        let newId = Int(arc4random_uniform(100000) + 1)
        
        let newFname = fnameInput.text!
        let newLname = lnameInput.text!
        let newPosition = positionInput.text!
        let newDob = dobInput.date
        
        //need to fix this
        let newHasDl = (yesNoPicker.selectedRow(inComponent: 0) == 0) ? "Yes":"No"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let stringDob = dateFormatter.string(from: newDob)
        
        
        let newEmplParams = [
            
            "id" : newId,
            "fname": newFname,
            "lname": newLname,
            "dob": stringDob,
            "hasDrivingLicense": newHasDl,
            "position":newPosition
            
            ] as [String : Any]
        
        //might change this to a heroku-app server.
        //for local tests, you need node, npm, and expressJS installed
        Alamofire.request("https://emalocalserver.herokuapp.com/em", method: .post,parameters:newEmplParams,encoding:JSONEncoding.default,headers:nil).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if(json["status"] == "valid"){
                        self.performSegue(withIdentifier: "backToTable", sender: self)
                }
                else{
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        
        
    }
    
}


