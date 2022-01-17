//
//  TabViewController.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-01-11.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient.getStudentLocation(completion: handleStudentResponse(success:error:))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         TODO
    }
    
    func handleStudentResponse(success: [LocationResult]?, error: Error?) {
        if success != nil {
            print("TableVC", success?.count ?? 0)
            LocationModel.locationList = success!
            self.tableView.reloadData()
        } else {
            print("TableVC", error?.localizedDescription ?? "")
        }
    }
    
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationModel.locationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // print("tableview ======== ", tableView)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
        
        let location = LocationModel.locationList[indexPath.row]
        
        cell.textLabel?.text = location.firstName + " " + location.lastName
        cell.detailTextLabel?.text = location.mapString
        cell.imageView?.image = UIImage.init(named: "Icon_Pin")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
