//
//  AddViewController.swift
//  Test
//
//  Created by Zehao Zhang on 15/3/11.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, addOptionsProtocol, bucketCellProtocol, SetUpProtocol {
    let screenSize:CGRect = UIScreen.mainScreen().bounds;
    let addOptionsMargin:CGFloat = 0.2;
    var scrollViewX:CGFloat = 0;
    var scrollViewY:CGFloat = 0;
    var scrollViewW:CGFloat = 0;
    var scrollViewH:CGFloat = 0;
    let scrollViewMarginProportion:CGFloat = 1;
    let scrollViewHeightProportion:CGFloat = 0.4;
    var bucketList:BucketList!
    var delete = false;
    var firstTime = true;
    
    var trackerModel:TrackerModel = TrackerModel();
    
    @IBOutlet var addButton:UIButton!;
    @IBOutlet var deleteButton:UIButton!;
    @IBOutlet var addOptionsContainer:UIVisualEffectView!;
    @IBOutlet var addOptions:AddOptionsView!;
    @IBOutlet var firstTimeSetUp:FirstTimeView!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpBucketList();
        self.setUpAddOptions(self.view.frame);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpModel(){
        
    }
    
    func setTotalBudget(totalBudget: Double){
        
    }
    
    func setUpBucketList(){
        let screenWidth = screenSize.width;
        let screenHeight = screenSize.height;
        scrollViewX = screenWidth * (1-scrollViewMarginProportion) / 2;
        scrollViewY = screenHeight * scrollViewHeightProportion;
        scrollViewW = screenWidth * scrollViewMarginProportion;
        scrollViewH = screenHeight - scrollViewY - scrollViewX;
        // Do any additional setup after loading the view, typically from a nib.
        bucketList = BucketList(frame: CGRect(x: scrollViewX, y: scrollViewY, width: scrollViewW, height: scrollViewH));
        bucketList.bucketCellDelegate = self;
        self.view.addSubview(bucketList!);
    }
    
    func setUpAddOptions(frame:CGRect){
        var blurEffect:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light);
        self.addOptionsContainer = UIVisualEffectView(effect: blurEffect);
        self.addOptionsContainer.frame = self.view.frame;
        var addOptionsX = frame.width * addOptionsMargin;
        var addOptionsY = frame.height * addOptionsMargin;
        var addOptionsW = frame.width * (1 - 2 * addOptionsMargin);
        var addOptionsH = frame.height * (1 - 2 * addOptionsMargin);
        var addOptionsFrame = CGRect(x: addOptionsX, y: addOptionsY, width: addOptionsW, height: addOptionsH);
        self.addOptions = AddOptionsView(frame: addOptionsFrame);
        self.view.addSubview(addOptionsContainer)
        self.view.addSubview(addOptions);
        addOptions.delegate = self;
        addOptions.hidden = true;
        addOptionsContainer.hidden = true;
    }
    
    func setUpFirstTime(frame:CGRect){
        var addOptionsX = frame.width * addOptionsMargin;
        var addOptionsY = frame.height * addOptionsMargin;
        var addOptionsW = frame.width * (1 - 2 * addOptionsMargin);
        var addOptionsH = frame.height * (1 - 2 * addOptionsMargin);
        var addOptionsFrame = CGRect(x: addOptionsX, y: addOptionsY, width: addOptionsW, height: addOptionsH);
        self.firstTimeSetUp = FirstTimeView(frame: addOptionsFrame);
        self.view.addSubview(firstTimeSetUp);
        firstTimeSetUp.delegate = self;
        firstTimeSetUp.hidden = true;
        addOptionsContainer.hidden = true;
    }
    
    @IBAction func addTapped(sender : AnyObject) {
        UIView.animateWithDuration(0.8, delay: 0.2, options: .CurveEaseOut, animations: {
            self.addOptions.hidden = false;
            self.addOptionsContainer.hidden = false;

        }, completion: { finished in
                //println("Buckets moved")
        })
    }
    
    func displayAlert(name:String){
        let alertController = UIAlertController(title: "Name used", message:
            "Bucket:" + name + " has already been created", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func addBucketCell(name: String, budget: Double, hue:CGFloat) {
        UIView.animateWithDuration(0.8, delay: 0.2, options: .CurveEaseOut, animations: {
            if(self.bucketList != nil){
                self.bucketList?.addNewBucket(name, limit: budget, hue:hue);
            }
            self.addOptions.hidden = true;
            self.addOptionsContainer.hidden = true;
            
            }, completion: { finished in
                //println("Buckets moved")
        })
    }
    
    func cancelAddOption() {
        UIView.animateWithDuration(0.8, delay: 0.2, options: .CurveEaseOut, animations: {
            self.addOptions.hidden = true;
            self.addOptionsContainer.hidden = true;
            
            }, completion: { finished in
                //println("Buckets moved")
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "mainToBucket"){
            let bucketViewController = segue.destinationViewController as! BucketViewController;
            let bucketModel = sender as! BucketModel;
            bucketViewController.bucket = bucketModel;
        }
    }
    
    @IBAction func deleteTapped(sender:AnyObject){
        if(!delete){
            self.deleteButton.setTitle("Delete", forState: UIControlState.Normal);
            self.delete = true;
        }else{
            self.deleteButton.setTitle("Cancel", forState: UIControlState.Normal);
            self.delete = false;
        }
    }
    
    func deleteBucketCell(bucket:BucketCell){
        self.bucketList!.deleteBucketCell(bucket);
    }
    
    @IBAction func bucketTapped(sender:BucketCell){
        let bucket = sender;
        if(delete){
            self.deleteBucketCell(bucket);
            delete = false;
        }else{
        }
        
    }
    
    func goToBucketView(bucket:BucketModel){
        
    }
    
    @IBAction func unwindFromBucketViewController(segue: UIStoryboardSegue){
        
    }
}