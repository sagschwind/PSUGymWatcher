//
//  ViewController.swift
//  PSUGymWatcher
//
//  Created by Steven Gschwind on 8/24/16.
//  Copyright © 2016 Steven Gschwind. All rights reserved.
//

/*
 PSU Dark Blue: rgb(0,48,135)
 Light Gray:    rgb(200,200,200)
 */

import UIKit

class ViewController: UIViewController {
    
    var buildingNames:[String]! // This orders the way the building shows up on the first screen
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    
    var labelGym: [UILabel] = []
    
    @IBOutlet weak var progressBarOne: UIProgressView!
    @IBOutlet weak var progressBarTwo: UIProgressView!
    @IBOutlet weak var progressBarThree: UIProgressView!
    
    var progressBar: [UIProgressView] = []
    
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    var lastUpdate: NSDate = NSDate(timeIntervalSince1970: NSTimeInterval())
    
    let updateDelayTime: Double = 1.0 // Time in seconds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildingNames = NSUserDefaults().objectForKey("buildingNamesList") as! Array
        
        labelGym.append(labelOne)
        labelGym.append(labelTwo)
        labelGym.append(labelThree)
 
        
        progressBar.append(progressBarOne)
        progressBar.append(progressBarTwo)
        progressBar.append(progressBarThree)
        
        updateNumbers(UITapGestureRecognizer())

        progressBar[0].layer.cornerRadius = 6
        progressBar[0].layer.masksToBounds = true
        progressBar[0].clipsToBounds = true
        
        progressBar[1].layer.cornerRadius = 6
        progressBar[1].layer.masksToBounds = true
        progressBar[1].clipsToBounds = true
        
        progressBar[2].layer.cornerRadius = 6
        progressBar[2].layer.masksToBounds = true
        progressBar[2].clipsToBounds = true
        
        updateNumbers(UITapGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateNumbers(sender: UITapGestureRecognizer) {
        if NSDate().timeIntervalSinceDate(lastUpdate) >= updateDelayTime{
            //var buildings: Dictionary<String,[Int]> = [buildingNames[0]:[0,0], buildingNames[1]:[0,0], buildingNames[2]:[0,0]]
            var buildingMaxCounts: Dictionary<String,UInt32> = ["IM Weight Room": UInt32(250), "Hepper Fitness Center": UInt32(240), "White Building": UInt32(210)]
            
            var currentName = ""
            
            /* This was the old JSON parser to gather information about gyms before the API was made private
            
            let data = NSData(contentsOfURL: NSURL(string: "https://studentaffairs.psu.edu/CurrentFitnessAttendance/api/CounterAPI")!)
        
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                for x in 0...2{
                    if let building = json[x] as? [String: AnyObject] {
                        if let buildingName = building["LocationDescription"] as? String {
                                    currentName = buildingName
                        }
                        if let currentVal = building["CurrentVal"] as? Int {
                            buildings[currentName]![0] = currentVal
                            //print (currentVal)
                        }
                        if let maxVal = building["MaxVal"] as? Int {
                            buildings[currentName]![1] = maxVal
                            //print (maxVal)
                        }
                    }
                }
            } catch {
            }
            */
            
            for x in 0...2{
                currentName = buildingNames[x]
            
                let currentCount = Int(arc4random_uniform(buildingMaxCounts[currentName]!)) //The current count is now random due to APICounter being private
                let maxCount = buildingMaxCounts[currentName]!
                    labelGym[x].text = currentName + " - (\(currentCount) / \(maxCount))"
                    progressBar[x].setProgress((Float(currentCount)/Float(maxCount)), animated: true)
            }
            
            lastUpdate = NSDate()
        
            let date = NSDate();
        
            let formatter = NSDateFormatter();
            formatter.dateFormat = "HH:mm:ss";
            let defaultTimeZoneStr = formatter.stringFromDate(date);
        
            lastUpdateLabel.text = "Last Updated: \(defaultTimeZoneStr)"
        }
        else if NSUserDefaults().objectForKey("updateAPIAlert") as! Bool{
            let alertController = UIAlertController(title: "Gym Tracker", message:
                    "To reduce strain on servers,\nupdates can only happen once every \(updateDelayTime) seconds", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}


