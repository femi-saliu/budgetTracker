//
//  SettingsViewController.swift
//  Test
//
//  Created by Anthony Davanzo on 4/15/15.
//  Copyright (c) 2015 Zehao Zhang. All rights reserved.
//


import UIKit



class SettingsViewController: UITableViewController {
    
    @IBAction func ChangeTotalBudget(sender: UIButton) {
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
    
}


