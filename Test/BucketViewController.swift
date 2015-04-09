//
//  BucketViewController.swift
//  Test
//
//  Created by Zehao Zhang on 15/4/7.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

class BucketViewController: UIViewController {
    var bucketView:BucketView!
    var bucketName:String?
    var bucket:BucketModel?
    
    override func viewDidLoad() {
        bucketView = BucketView(frame: self.view.frame);
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadBucketWithModel(model:BucketModel){
        
    }
    
}