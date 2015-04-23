//
//  BucketViewController.swift
//  Test
//
//  Created by Zehao Zhang on 15/4/7.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

class BucketViewController: UIViewController, BucketAddProtocol, BucketViewProtocol, TransactionCellProtocol {
    var bucketView:BucketView!
    var bucketName:String = "";
    //var bucket:BucketModel!
    var tracker:TrackerModel!
    
    let popUpViewMargin:CGFloat = 0.15;
    
    let bucketViewTopMargin:CGFloat = 0.1;
    let bucketViewProportion:CGFloat = 0.5;
    let scrollViewMarginProportion:CGFloat = 1;
    var bucketViewX:CGFloat = 0;
    var bucketViewY:CGFloat = 0;
    var bucketViewW:CGFloat = 0;
    var bucketViewH:CGFloat = 0;
    
    var transactionList:TransactionList!;
    
    var inDelete:Bool = false;
    
    @IBOutlet var bucketAddView:BucketAddView!;
    @IBOutlet var subviewContainer:UIVisualEffectView!;
    
    override func viewDidLoad() {
        self.loadBucketView(self.view.frame);
        self.loadBucketWithModel(tracker);
        self.loadTransactionList(self.view.frame);
        self.loadTransactionListWithModel(tracker);
        self.setUpBucketAdd(self.view.frame);
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
        bucketView.delegate = self;
        self.view.addSubview(bucketView);
    }
    
    func loadBucketWithModel(model:TrackerModel){
        self.bucketView.setColor(model.getColorWithBucket(bucketName)!);
        self.bucketView.setTitle(bucketName);
        self.bucketView.setSpending(model.getLimitWithBucket(bucketName)!, spending: model.getSpendingWithBucket(bucketName)!);
    }
    
    func loadTransactionList(frame:CGRect){
        let screenWidth = frame.width;
        let screenHeight = frame.height;
        let scrollViewX = screenWidth * (1-scrollViewMarginProportion) / 2;
        let scrollViewY = screenHeight * (1 - bucketViewProportion);
        let scrollViewW = screenWidth * scrollViewMarginProportion;
        let scrollViewH = screenHeight - scrollViewY;
        transactionList = TransactionList(frame: CGRect(x: scrollViewX, y: scrollViewY, width: scrollViewW, height: scrollViewH));
        transactionList.transactionCellDelegate = self;
        self.view.addSubview(transactionList!);

    }
    
    func loadTransactionListWithModel(model:TrackerModel){
        let transactions = model.getTransactionsWithName(bucketName);
        let descriptions = model.getDescriptionsWithName(bucketName);
        let types = model.getTransactionTypesWithName(bucketName);
        let signs = model.getTransactionSignsWithName(bucketName);
        
        assert(transactions.count == descriptions.count, "transaction & descriptions length not equal");
        for(var i = 0; i<transactions.count; i++){
            self.transactionList.addNewTransaction(descriptions[i], amount: transactions[i], type:types[i], sign:signs[i]);
        }
    }
    
    func setUpBucketAdd(frame:CGRect){
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
    
    func transactionDeleted(name: String, amt:Double) {
        self.tracker.removeTransactionWithName(bucketName, desc: name, amt:amt);
        self.loadBucketWithModel(tracker);
    }
    
    func addTransaction(amt: Double, desc:String, type:Int) -> Bool{
        if(self.tracker.addNewTransaction(bucketName, amount: amt, desc: desc)){
            self.bucketAddView.hidden = true;
            self.subviewContainer.hidden = true;
            self.transactionList.addNewTransaction(desc, amount: amt, type:type, sign:-1);
            self.loadBucketWithModel(tracker);
            return true;
        }else{
            return false;
        }
    }
    
    func characterOverFlow() {
        let alertController = UIAlertController(title: "Exceeded Text Length", message:
            "The description cannot be longer than 15 characters(Space included)", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func overBudget() {
        let alertController = UIAlertController(title: "Over Budget", message:
            "You have gone over budget", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Got it", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func cancel() {
        self.bucketAddView.hidden = true;
        self.subviewContainer.hidden = true;
    }
    
    func addTapped() {
        self.bucketAddView.hidden = false;
        self.subviewContainer.hidden = false;
    }
    
    func minusTapped() {
        if(!inDelete){
            inDelete = true;
            self.bucketView.setCancelMinus();
            self.transactionList.setDeleteMode(true);
        }else{
            inDelete = false;
            self.bucketView.setOriginalMinus();
            self.transactionList.setDeleteMode(false);
        }
    }
    
    func transactionTapped(sender: TransactionCell) {
        if(inDelete && sender.getType() == 0){
            self.transactionList.deleteTransactionCell(sender);
        }
    }
    
}