//
//  Storage.swift
//  finalPrep
//
//  Created by Adem Hadrovic on 6/8/18.
//  Copyright © 2018 SSST. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Storage {
    static let shared: Storage = Storage()
    
    var objects: [Employee]
    
    private init(){
        //maybe do json request for getting current employees here here?
        
        objects = [Employee]()
        
    }
}
