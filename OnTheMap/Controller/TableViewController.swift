//
//  TabViewController.swift
//  OnTheMap
//
//  Created by Dhara Bhavsar on 2022-01-11.
//  Copyright © 2022 Dhara Bhavsar. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController, UITabBarControllerDelegate {
    
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
    
    @IBAction func logoutClick(_ sender: UIButton) {
        APIClient.logout()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refreshClick(_ sender: UIButton) {
        APIClient.getStudentLocation(completion: handleStudentResponse(success:error:))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         TODO
    }
    
    func handleStudentResponse(success: [StudentInformation]?, error: Error?) {
        if success != nil {
            print("TableVC: ", success?.count ?? 0)
            LocationModel.locationList = success!
            self.tableView.reloadData()
        } else {
            print("TableVC: ", error?.localizedDescription ?? "")
            showErrorDialogBox(message: error?.localizedDescription ?? "")
        }
    }
    
    func showErrorDialogBox(message: String) {
        let alertVC = UIAlertController(title: "Error Encountered", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertVC, animated: true, completion: nil)
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
        cell.detailTextLabel?.text = location.mediaURL
        cell.imageView?.image = UIImage.init(named: "Icon_Pin")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        // TODO -< launch Safari & open link associated with the row
//        performSegue(withIdentifier: "showDetail", sender: nil)
        let location = LocationModel.locationList[indexPath.row]
        let url = location.mediaURL
        print("URL: ", url)
        if let appURL = URL(string: url) {
            UIApplication.shared.open(appURL) { success in
                if success {
                    print("The URL was delivered successfully.")
                } else {
                    print("The URL failed to open.")
                    self.showErrorDialogBox(message: "The URL failed to open.")
                }
            }
        } else {
            print("Invalid URL specified.")
            showErrorDialogBox(message: "Invalid URL specified.")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
