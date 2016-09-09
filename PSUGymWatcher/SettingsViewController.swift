//
//  SettingsViewController.swift
//  PSUGymWatcher
//
//  Created by Steven Gschwind on 8/26/16.
//  Copyright © 2016 Steven Gschwind. All rights reserved.
//

import UIKit

class SettingsViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var buildingsTableView: UITableView!
    @IBOutlet weak var toggleUpdateAlerts: UISwitch!
    
    var buildingNamesList = NSUserDefaults().objectForKey("buildingNamesList") as! [String]
    
    override func viewDidLoad() {
        self.buildingsTableView.delegate = self
        self.buildingsTableView.dataSource = self
        
        self.buildingsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "buildingCell")
        self.buildingsTableView.scrollEnabled = false
        self.buildingsTableView.setEditing(true, animated: true)
        
        self.toggleUpdateAlerts.addTarget(self, action: #selector(SettingsViewController.switchIsChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.toggleUpdateAlerts.on = NSUserDefaults().objectForKey("updateAPIAlert") as! Bool
    }
    
    //MARK: UITableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildingNamesList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("buildingCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = buildingNamesList[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row > buildingNamesList.count - 1 {
            return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        if(sourceIndexPath.row != destinationIndexPath.row){
            buildingNamesList.insert(buildingNamesList.removeAtIndex(sourceIndexPath.row), atIndex: destinationIndexPath.row)
            
        }
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("buildingNamesList")
        NSUserDefaults.standardUserDefaults().setObject(buildingNamesList, forKey: "buildingNamesList")
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    
    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    
    //MARK: UISwitch
    func switchIsChanged(switchState: UISwitch) {
        if toggleUpdateAlerts.on {
            NSUserDefaults().removeObjectForKey("updateAPIAlert")
            NSUserDefaults.standardUserDefaults().setBool(toggleUpdateAlerts.on, forKey: "updateAPIAlert")
        } else {
            NSUserDefaults().removeObjectForKey("updateAPIAlert")
            NSUserDefaults.standardUserDefaults().setBool(toggleUpdateAlerts.on, forKey: "updateAPIAlert")
            
            let alertController = UIAlertController(title: "Toggled off", message:
                "Toggling alerts off will not turn off the update delay", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
}