//
//  MasterViewController.swift
//  finalPrep
//
//  Created by Adem Hadrovic on 6/8/18.
//  Copyright © 2018 SSST. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = Storage.shared.objects
    //need to get from server here
    
    /*
    func getEmployees() -> Void{
        
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        //dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        
        Alamofire.request("http://localhost:3000/employees").responseJSON { response in
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                print("first element: \(JSON(json)[0])")
                
                let jsonEmployees = JSON(json)
                
                for i in 1...jsonEmployees.count{
                    
                    
                    let fname = jsonEmployees[i]["fname"].rawValue as! String
                    let lname = jsonEmployees[i]["lname"].rawValue as! String
                    let dob = jsonEmployees[i]["dob"].rawValue as! String
                    let hasDrivingLicense = jsonEmployees[i]["hasDrivingLicense"].rawValue as! String
                    let position = jsonEmployees[i]["position"].rawValue as! String
                    
                    let empl = Employee(fname: fname, lname: lname, dob: dob, hasDrivingLicense: hasDrivingLicense, position: position)
                    
                    self.objects.append(empl)
                    
                }
                
            }
            
        }
        tableView.reloadData()
    }
    */

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        Alamofire.request("https://emalocalserver.herokuapp.com/employees").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for (_, subJson):(String, JSON) in json {
                    
                    let newId = subJson["id"].rawValue as! Int
                    let newFname = subJson["fname"].rawValue as! String
                    let newLname = subJson["lname"].rawValue as! String
                    let newDob = subJson["dob"].rawValue as! String
                    let newHasDl = subJson["hasDrivingLicense"].rawValue as! String
                    let newPosition = subJson["position"].rawValue as! String
                    
                    let newEmployee = Employee(id:newId, fname: newFname, lname: newLname, dob: newDob, hasDrivingLicense: newHasDl, position: newPosition)
                    self.objects.append(newEmployee)
                }
                
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
        performSegue(withIdentifier: "addNewEmployee", sender: self)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailEmployee = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EmployeeTableViewCell

        let object = objects[indexPath.row]
        
        cell.fnameLabel.text! = object.fname
        cell.lnameLabel.text! = object.lname
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            let selectedEmployee = self.objects[indexPath.row]
            //Storage.shared.objects.remove(at: indexPath.row)
            objects.remove(at: indexPath.row)
            
            let params = [ "id": selectedEmployee.id, "dob": selectedEmployee.dob ] as [String : Any]
            
            Alamofire.request("https://emalocalserver.herokuapp.com/employees", method: .delete,parameters:params,encoding:JSONEncoding.default,headers:nil).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                case .failure(let error):
                    print(error)
                }
            }
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

