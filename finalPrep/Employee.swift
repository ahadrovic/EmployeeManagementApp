//
//  Employee.swift
//  finalPrep
//
//  Created by Adem Hadrovic on 6/8/18.
//  Copyright © 2018 SSST. All rights reserved.
//

import Foundation


class Employee{
    
    var id:Int
    var fname:String
    var lname:String
    var dob:String
    var hasDrivingLicense:String
    var position:String
    
    init(id:Int, fname:String,lname:String,dob:String,hasDrivingLicense:String,position:String) {
        
        //id is used in the API
        self.id = id
        self.fname = fname
        self.lname = lname
        self.dob = dob
        self.hasDrivingLicense = hasDrivingLicense
        self.position = position
        
    }
    
}
