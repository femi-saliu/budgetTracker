//
//  AddViewController.swift
//  Test
//
//  Created by Zehao Zhang on 15/3/11.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    let screenSize:CGRect = UIScreen.mainScreen().bounds;
    var scrollViewX:CGFloat = 0;
    var scrollViewY:CGFloat = 0;
    var scrollViewW:CGFloat = 0;
    var scrollViewH:CGFloat = 0;
    let scrollViewMarginProportion:CGFloat = 0.9;
    let scrollViewHeightProportion:CGFloat = 0.5;
    var bucketList:BucketList?
    
    @IBOutlet var addButton:UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth = screenSize.width;
        let screenHeight = screenSize.height;
        scrollViewX = screenWidth * (1-scrollViewMarginProportion) / 2;
        scrollViewY = screenHeight * scrollViewHeightProportion;
        scrollViewW = screenWidth * scrollViewMarginProportion;
        scrollViewH = screenHeight - scrollViewY - scrollViewX;
        // Do any additional setup after loading the view, typically from a nib.
        bucketList = BucketList(frame: CGRect(x: scrollViewX, y: scrollViewY, width: scrollViewW, height: scrollViewH));
        self.view.addSubview(bucketList!);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTapped(sender : AnyObject) {
        if(bucketList != nil){
            bucketList?.addNewBucket("new bucket", limit: 100);
        }
    }
    
    
}