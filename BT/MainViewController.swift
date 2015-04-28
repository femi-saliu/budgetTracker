//
//  ViewController.swift
//  BT
//
//  Created by Zehao Zhang on 15/4/21.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, addOptionsProtocol, bucketCellProtocol, SetUpProtocol, TransferProtocol{
    let screenSize:CGRect = UIScreen.mainScreen().bounds;
    let addOptionsMargin:CGFloat = 0.15;
    
    var trackerData = [NSManagedObject]();
    var mainData = [NSManagedObject]();
    var bucketData = [NSManagedObject]();
    var transactionData = [NSManagedObject]();
    
    var scrollViewX:CGFloat = 0;
    var scrollViewY:CGFloat = 0;
    var scrollViewW:CGFloat = 0;
    var scrollViewH:CGFloat = 0;
    let scrollViewMarginProportion:CGFloat = 1;
    let scrollViewHeightProportion:CGFloat = 0.4;
    
    var bucketList:BucketList!
    
    let totalBudgetTopMargin:CGFloat = 0.1;
    var totalBudgetX:CGFloat = 0;
    var totalBudgetY:CGFloat = 0;
    var totalBudgetW:CGFloat = 0;
    var totalBudgetH:CGFloat = 0;
    
    var totalBudgetView:TotalBudgetView!
    
    var delete = false;
    var transfer = false;
    var transferFromSelected = false;
    var firstTime = false;
    
    var trackerModel:TrackerModel = TrackerModel();
    
    var selectedBucketModel:BucketModel!
    var selectedBucketName = "";
    
    var transferFromName = "";
    var transferToName = "";
    
    @IBOutlet var addButton:UIButton!;
    @IBOutlet var deleteButton:UIButton!;
    @IBOutlet var transferButton:UIButton!;
    @IBOutlet var addOptionsContainer:UIVisualEffectView!;
    @IBOutlet var addOptions:AddOptionsView!;
    @IBOutlet var transferView:TransferView!;
    @IBOutlet var firstTimeSetUp:FirstTimeView!;
    
    
    override func viewDidLoad() {
        println("ADDViewControllerVDL");
        super.viewDidLoad()
        self.readFromData();
        self.setUpBucketList();
        self.setUpTotalBudgetView();
        self.setUpAddOptions(self.view.frame);
        self.setUpForFirstTime(self.view.frame);
        self.setUpTransferView(self.view.frame);
        if(firstTime){
            firstTimeSetUp.hidden = false;
            addOptionsContainer.hidden = false;
        }else{
            self.setUpModel();
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readFromData(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        
        let managedContext = appDelegate.managedObjectContext!;
        
        let trackerFetchRequest = NSFetchRequest(entityName:"Tracker");
        
        let bucketFetchRequest = NSFetchRequest(entityName: "Bucket");
        
        let transactionFetchRequest = NSFetchRequest(entityName: "Transactions");
        
        let mainFetchRequest = NSFetchRequest(entityName: "Main");
        
        var error: NSError?
        
        let fetchedTrackerResult = managedContext.executeFetchRequest(trackerFetchRequest, error: &error) as? [NSManagedObject];
        
        let fetchedBucketResult = managedContext.executeFetchRequest(bucketFetchRequest, error: &error) as? [NSManagedObject];
        
        let fetchedTransactionResult = managedContext.executeFetchRequest(transactionFetchRequest, error: &error) as? [NSManagedObject];
        
        let fetchedMainResult = managedContext.executeFetchRequest(mainFetchRequest, error: &error) as? [NSManagedObject];
        
        if let mResult = fetchedMainResult{
            if(mResult.count < 1){
                self.firstTime = true;
            }else{
                self.mainData = mResult;
            }
        }
        
        if let tResult = fetchedTrackerResult{
            if(tResult.count > 0){
                self.trackerData = tResult;
            }else{
                println("no tracker data");
            }
        } else {
            println("Could not fetch \(error), \(error!.userInfo)");
        }
        
        if let bResult = fetchedBucketResult {
            bucketData = bResult;
        } else {
            println("Could not fetch \(error), \(error!.userInfo)");
        }
        
        if let trResult = fetchedTransactionResult {
            transactionData = trResult;
        } else {
            println("Could not fetch \(error), \(error!.userInfo)");
        }
    }
    
    func saveMain(){
        let appDelegate =
        UIApplication.sharedApplication().delegate! as! AppDelegate;
        
        let managedContext = appDelegate.managedObjectContext!;
        
        let entity =  NSEntityDescription.entityForName("Main",
            inManagedObjectContext:
            managedContext);
        
        let main = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext);
        
        main.setValue(false, forKey: "firstTime");
        main.setValue("main", forKey: "name");
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
    
    func saveTrackerData(totalBudget:Double, hue:CGFloat){
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate;
        
        let managedContext = appDelegate.managedObjectContext!;
        
        let entity =  NSEntityDescription.entityForName("Tracker",
            inManagedObjectContext:
            managedContext);
        
        let tracker = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext);
        
        tracker.setValue(hue, forKey: "currentHue");
        tracker.setValue(totalBudget, forKey: "totalLimit");
        tracker.setValue("tracker", forKey: "name");
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        trackerData.append(tracker);
    }
    
    func setUpModel(){
        self.trackerModel.loadTrackerWithData(trackerData, bucketData: bucketData, transactionData: transactionData);
        self.loadBucketsWithData();
    }
    
    func setTotalBudget(totalBudget: Double, hue:CGFloat){
        self.trackerModel.setTotalBudget(totalBudget);
        self.trackerModel.setMainHue(hue);
        self.totalBudgetView!.setTotalBudget(totalBudget);
        self.totalBudgetView.setColor(self.trackerModel.getMainColor());
        if(firstTime){
            self.saveMain();
            self.saveTrackerData(totalBudget, hue: hue);
            firstTimeSetUp.hidden = true;
            addOptionsContainer.hidden = true;
            firstTime = false;
        }
    }
    
    func setUpTotalBudgetView(){
        let screenWidth = self.view.frame.width;
        let screenHeight = self.view.frame.height;
        totalBudgetX = 0;
        totalBudgetY = screenHeight * totalBudgetTopMargin;
        totalBudgetW = screenWidth + scrollViewMarginProportion;
        totalBudgetH = screenHeight * scrollViewHeightProportion - totalBudgetY - 2;
        totalBudgetView = TotalBudgetView(frame: CGRect(x: totalBudgetX, y: totalBudgetY, width: totalBudgetW, height: totalBudgetH));
        self.view.addSubview(totalBudgetView!);
    }
    
    func setUpBucketList(){
        let screenWidth = self.view.frame.width;
        let screenHeight = self.view.frame.height;
        scrollViewX = screenWidth * (1-scrollViewMarginProportion) / 2;
        scrollViewY = screenHeight * scrollViewHeightProportion;
        scrollViewW = screenWidth * scrollViewMarginProportion;
        scrollViewH = screenHeight - scrollViewY - scrollViewX;
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
    
    func setUpForFirstTime(frame:CGRect){
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
    
    func setUpTransferView(frame:CGRect){
        var addOptionsX = frame.width * addOptionsMargin;
        var addOptionsY = frame.height * addOptionsMargin;
        var addOptionsW = frame.width * (1 - 2 * addOptionsMargin);
        var addOptionsH = frame.height * (1 - 2 * addOptionsMargin);
        var addOptionsFrame = CGRect(x: addOptionsX, y: addOptionsY, width: addOptionsW, height: addOptionsH);
        self.transferView = TransferView(frame: addOptionsFrame);
        self.view.addSubview(transferView);
        transferView.delegate = self;
        transferView.hidden = true;
        addOptionsContainer.hidden = true;
    }
    
    @IBAction func addTapped(sender : AnyObject) {
        self.addOptions.setAvailableAmt(self.trackerModel.getAvailableBudget());
        self.addOptions.hidden = false;
        self.addOptionsContainer.hidden = false;
    }
    
    func displayNameAlert(name:String){
        let alertController = UIAlertController(title: "Name used", message:
            "Bucket:" + name + " has already been created", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func displayOverLimitAlert(){
        let alertController = UIAlertController(title: "Over Budget", message:
            "You have exceeded the totoal budget", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func emptyAlert(){
        let alertController = UIAlertController(title: "Name/Budget empty", message:
            "Name / Budget field cannot be emoty", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func addBucketCell(name: String, budget: Double, hue:CGFloat)->Bool{
        var result = self.trackerModel.addNewBucket(name, limit: budget, hue: hue)
        if(result == "success"){
            if(self.bucketList != nil){
                self.bucketList?.addNewBucket(name, limit: budget);
                var bucketColor = self.trackerModel.getColorWithBucket(name);
                self.bucketList?.setBucketColorWithName(name, color: bucketColor!);
            }
            self.addOptions.hidden = true;
            self.addOptionsContainer.hidden = true;
            return true;
        }else{
            if(result == "replicate"){
                self.displayNameAlert(name);
            }else{
                self.displayOverLimitAlert();
            }
            return false;
        }
    }
    
    func cancelAddOption() {
        self.addOptions.hidden = true;
        self.addOptionsContainer.hidden = true;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "presentBucket"){
            let bucketViewController = segue.destinationViewController as! BucketViewController;
            bucketViewController.bucketName = self.selectedBucketName;
            bucketViewController.tracker = self.trackerModel;
        }
    }
    
    @IBAction func deleteTapped(sender:AnyObject){
        if(!delete){
            self.deleteButton.setTitle("Cancel", forState: UIControlState.Normal);
            self.delete = true;
            self.bucketList.setDeleteMode(delete);
        }else{
            self.deleteButton.setTitle("Delete", forState: UIControlState.Normal);
            self.delete = false;
            self.bucketList.setDeleteMode(delete);
        }
    }
    
    @IBAction func transferTapped(sender:AnyObject){
        if(!transfer){
            if(self.trackerModel.numOfBuckets()>1){
                self.transferButton.setTitle("Cancel", forState: .Normal);
                self.transfer = true;
                self.transferFromSelected = false;
                self.bucketList.setTransferMode(1);
            }else{
                self.insufficientBuckets();
            }
        }else{
            self.transferButton.setTitle("Transfer", forState: .Normal);
            self.transfer = false;
            self.transferFromSelected = false;
            self.bucketList.setTransferMode(0);
        }
    }
    
    func deleteBucketCell(bucket:BucketCell){
        self.trackerModel.removeBucket(bucket.getName());
        self.bucketList!.deleteBucketCell(bucket);
        self.loadBucketsWithModel();
    }
    
    func loadBucketsWithData(){
        self.totalBudgetView.setSpending(self.trackerModel.getSpending());
        self.totalBudgetView.setColor(self.trackerModel.getMainColor());
        self.totalBudgetView.setTotalBudget(self.trackerModel.getLimit());
        let buckets = self.trackerModel.getBuckets();
        for bucket in buckets{
            self.bucketList.addNewBucket(bucket.getName(), limit: bucket.getLimit());
            self.bucketList.setBucketColorWithName(bucket.getName(), color:bucket.getColor());
            self.bucketList.setBucketSpendingWithName(bucket.getName(), s:bucket.currentBalance());
        }
    }
    
    func loadBucketsWithModel(){
        self.totalBudgetView.setSpending(self.trackerModel.getSpending());
        self.totalBudgetView.setColor(self.trackerModel.getMainColor());
        self.totalBudgetView.setTotalBudget(self.trackerModel.getLimit());
        let buckets = self.trackerModel.getBuckets();
        for bucket in buckets{
            self.bucketList.setBucketColorWithName(bucket.getName(), color:bucket.getColor());
            self.bucketList.setBucketSpendingWithName(bucket.getName(), s:bucket.currentBalance());
            self.bucketList.setBucketLimitWithName(bucket.getName(), l: bucket.getLimit());
        }
    }
    
    @IBAction func bucketTapped(sender:BucketCell){
        let bucket = sender;
        if(delete){
            self.deleteBucketCell(bucket);
        }else if(transfer){
            if(!transferFromSelected){
                self.bucketList.setTransferMode(2);
                transferFromSelected = true;
                transferFromName = sender.getName();
            }else{
                transferToName = sender.getName();
                self.transferView.hidden = false;
                self.addOptionsContainer.hidden = false;
            }
        }else{
            self.selectedBucketName = sender.getName();
            self.goToBucketView();
        }
        
    }
    
    func cancelTransfer() {
        self.transferView.hidden = true;
        self.addOptionsContainer.hidden = true;
    }
    
    func overTransferBudget() {
        let alertController = UIAlertController(title: "Insufficient budget", message:
            "Not enough budget to be transfered", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func insufficientBuckets() {
        let alertController = UIAlertController(title: "Insufficient buckets", message:
            "Not enough bucket to perform transfer", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func transfer(amt:Double)->Bool{
        if(self.trackerModel.transfer(transferFromName, to: transferToName, amount: amt)){
            self.loadBucketsWithModel();
            self.transferView.hidden = true;
            self.addOptionsContainer.hidden = true;
            self.transferFromSelected = false;
            self.transfer = false;
            self.bucketList.setTransferDone();
            self.transferButton.setTitle("Transfer", forState: .Normal);
            return true;
        }else{
            return false;
        }
    }
    
    func goToBucketView(){
        self.performSegueWithIdentifier("presentBucket", sender: self);
    }
    
    @IBAction func unwindFromBucketViewController(segue: UIStoryboardSegue){
        println("unwind");
        self.loadBucketsWithModel();
    }
}
