//
//  SettingsViewController.swift
//  Test
//
//  Created by Anthony Davanzo on 3/30/15.
//  Copyright (c) 2015 Zehao Zhang. All rights reserved.
//

import UIKit

class SettingsViewController: UINavigationController {
    let screenSize:CGRect = UIScreen.mainScreen().bounds;
    var scrollViewX:CGFloat = 0;
    var scrollViewY:CGFloat = 0;
    var scrollViewW:CGFloat = 0;
    var scrollViewH:CGFloat = 0;
    let scrollViewMarginProportion:CGFloat = 0.9;
    let scrollViewHeightProportion:CGFloat = 0.5;

    
    @IBOutlet var addButton:UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}