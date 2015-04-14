//
//  BucketViewController.swift
//  Test
//
//  Created by Zehao Zhang on 15/4/7.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

class BucketViewController: UIViewController, BucketAddProtocol {
    var bucketView:BucketView!
    var bucketName:String = "";
    //var bucket:BucketModel!
    var tracker:TrackerModel!
    
    let popUpViewMargin:CGFloat = 0.15;
    
    let bucketViewTopMargin:CGFloat = 0.1;
    let bucketViewProportion:CGFloat = 0.5;
    var bucketViewX:CGFloat = 0;
    var bucketViewY:CGFloat = 0;
    var bucketViewW:CGFloat = 0;
    var bucketViewH:CGFloat = 0;
    
    @IBOutlet var bucketAddView:BucketAddView!;
    @IBOutlet var subviewContainer:UIVisualEffectView!;
    
    override func viewDidLoad() {
        println("BucketViewControllerVDL");
//        bucketView = BucketView(frame: self.view.frame);
//        self.view.addSubview(bucketView);
        self.loadBucketView(self.view.frame);
        self.loadBucketWithModel(tracker);
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadBucketView(frame:CGRect){
        bucketViewY = frame.height * bucketViewTopMargin;
        bucketViewW = frame.width;
        bucketViewH = frame.height * (bucketViewProportion - bucketViewTopMargin);
        bucketView = BucketView(frame: CGRect(x: bucketViewX, y: bucketViewY, width: bucketViewW, height: bucketViewH));
        self.view.addSubview(bucketView);
    }
    
    func loadBucketWithModel(model:TrackerModel){
        self.bucketView.setColor(model.getColorWithBucket(bucketName)!);
        self.bucketView.setTitle(bucketName);
        self.bucketView.setSpending(model.getLimitWithBucket(bucketName)!, spending: model.getSpendingWithBucket(bucketName)!);
    }
    
    func setUpAddOptions(frame:CGRect){
        var blurEffect:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light);
        self.subviewContainer = UIVisualEffectView(effect: blurEffect);
        self.subviewContainer.frame = self.view.frame;
        var bucketAddX = frame.width * popUpViewMargin;
        var bucketAddY = frame.height * popUpViewMargin;
        var bucketAddW = frame.width * (1 - 2 * popUpViewMargin);
        var bucketAddH = frame.height * (1 - 2 * popUpViewMargin);
        var bucketAddFrame = CGRect(x: bucketAddX, y: bucketAddY, width: bucketAddW, height: bucketAddH);
        self.bucketAddView = BucketAddView(frame: bucketAddFrame);
        self.view.addSubview(subviewContainer)
        self.view.addSubview(bucketAddView);
        bucketAddView.delegate = self;
        bucketAddView.hidden = true;
        subviewContainer.hidden = true;
    }
    
    func addTransaction(amt: Double){
        self.tracker.addNewTransaction(bucketName, amount: amt);
        self.loadBucketWithModel(tracker);
    }
    
    func cancel() {
        
    }
    
}