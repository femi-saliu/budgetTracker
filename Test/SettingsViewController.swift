//
//  SettingsViewController.swift
//  Test
//
//  Created by Anthony Davanzo on 4/15/15.
//  Copyright (c) 2015 Zehao Zhang. All rights reserved.
//


import UIKit



class SettingsViewController: UITableViewController {
    
    @IBAction func ChangeTotalButton(sender: UIButton) {
    
            var alert = UIAlertController(title: "Warning! You are about to change your total budget!", message: "Change Total Buget", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Change", style: UIAlertActionStyle.Default, handler: nil))
            alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) in
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.placeholder = "<New Total Budget>"
            }
        self.presentViewController(alert, animated: true){
            let NewBudget = alert.textFields?.first as! UITextField;
            let budgetNum:Double = (NewBudget.text as NSString).doubleValue;
            println((budgetNum))
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func CalculateStartDate () {
        let calendar = NSCalendar.currentCalendar()
        let Start = NSDate()
        let components = calendar.components(.MonthCalendarUnit | .DayCalendarUnit | .YearCalendarUnit, fromDate: Start)
        
        var month = components.month
        
        var year = components.year
        
        var day = components.day
        
        func GetMonth()->Int{
            return month
        }
        func GetYear()->Int{
            return year
        }
        func Reset()->Bool{
            let calendar = NSCalendar(identifier: NSGregorianCalendar)
            
            let components = NSDateComponents()
            components.year = 1987
            components.month = 3
            components.day = 17
            components.hour = 14
            components.minute = 20
            components.second = 0
            
            let date = calendar!.dateFromComponents(components)
            if date != Start{
                return true
            }
            else{
                return false

            }
        }
   
        
    }
}



