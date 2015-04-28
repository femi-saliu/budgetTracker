//
//  TrackerModel.swift
//  Test
//
//  Created by Zehao Zhang on 15/3/11.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TrackerModel {
    var bucketObjects = [NSManagedObject]();
    var transactionData = [NSManagedObject]();
    var trackerData = NSManagedObject();
    var buckets = [BucketModel]();
    var totalLimit:Double = 0;
    var numBuckets=0;
    var bucketTotal:Double = 0;
    var currentSpending:Double = 0;
    var replicateName = "replicate";
    var overLimit = "overlimit";
    var emptyName = "empty";
    var success = "success";
    
    var currentHue:CGFloat = 0;
    let saturationLowerLimit:CGFloat = 20 / 100;
    let saturationUpperLimit:CGFloat = 100 / 100;
    var currentSaturation:CGFloat = 0;
    let defaultBrightness:CGFloat = 100 / 100;
    let defaultAlpha:CGFloat = 1;
    //let falseBucket = BucketModel(n: "", newlimit: 0, hue: 0);
    init() {
        self.currentSaturation = saturationLowerLimit;
    }
    
    func loadTrackerWithData(trackerData: NSManagedObject, bucketData: [NSManagedObject], transactionData: [NSManagedObject]){
        self.bucketObjects = bucketData;
        self.trackerData = trackerData;
        self.transactionData = transactionData;
        self.currentHue = self.trackerData.valueForKey("currentHue")! as! CGFloat;
        self.totalLimit = self.trackerData.valueForKey("totalLimit")!as! Double;
        for bucket in self.bucketObjects{
            let name = bucket.valueForKey("name")!as! String;
            let limit = bucket.valueForKey("limit")! as! Double;
            let hue = bucket.valueForKey("currentHue")! as! CGFloat;
            self.addNewBucket(name, limit: limit, hue: hue);
        }
        for transaction in self.transactionData{
            let bucketName = transaction.valueForKey("bucket")! as! String;
            let description = transaction.valueForKey("desc")! as! String;
            let amount = transaction.valueForKey("amount")! as! Double;
            let type = transaction.valueForKey("type")! as! Int;
            let sign = transaction.valueForKey("sign")! as! Int;
            self.loadTransactionData(bucketName, amount: amount, desc: description, type: type, sign: sign);
        }
    }
    
    func setTotalBudget(totalBudget:Double){
        totalLimit = totalBudget;
        
    }
    
    func getBuckets() -> [BucketModel]{
        return buckets;
    }
    
    func getTransactionsWithName(name:String) -> [Double]{
        return self.getBucket(name)!.getTransactions();
    }
    
    func getDescriptionsWithName(name:String) -> [String]{
        return self.getBucket(name)!.getDescriptions();
    }
    
    func getTransactionTypesWithName(name:String) -> [Int]{
        return self.getBucket(name)!.getTransactionTypes();
    }
    
    func getTransactionSignsWithName(name:String) -> [Int]{
        return self.getBucket(name)!.getTransactionSigns();
    }
    
    func setMainHue(hue:CGFloat){
        self.currentHue = hue;
    }
    
    func getMainColor() -> UIColor{
        let currentColor = UIColor(hue: currentHue, saturation: currentSaturation, brightness: defaultBrightness, alpha: defaultAlpha);
        return currentColor;
    }
    
    func addNewBucket(name:String, limit:Double, hue:CGFloat) -> String{
        for bucket in buckets{
            if(bucket.getName() == name){
                return replicateName;
            }
        }
        if(bucketTotal + limit > totalLimit){
            return overLimit;
        }
        var newBucket:BucketModel;
        newBucket = BucketModel(n:name,newlimit:limit, hue:hue);
        buckets.append(newBucket);
        bucketTotal += limit;
        numBuckets++;
        return success;
    }
    
    func removeTransactionWithName(name:String, desc:String, amt:Double){
        self.currentSpending -= amt;
        self.getBucket(name)!.removeTransaction(desc);
    }
    
    func numOfBuckets()->Int{
        return numBuckets;
    }
    
    func getSpending()->Double{
        return currentSpending;
    }
    
    func getAvailableBudget() -> Double {
        return totalLimit - bucketTotal;
    }
    
    func getBucket(name:String) -> BucketModel?{
        var index = 0;
        for bucket in buckets{
            if(bucket.getName() == name){
                return bucket;
            }
        }
        return nil;
    }
    
    func bucketHasTransaction(name:String)->Bool{
        return self.getBucket(name)!.spending != 0;
    }
    
    
    func removeBucket(name:String){
        var index = 0;
        for bucket in buckets{
            if(bucket.getName()==name){
                bucketTotal -= bucket.limit;
                currentSpending -= bucket.currentBalance();
                self.currentSaturation = saturationLowerLimit + CGFloat(currentSpending / totalLimit) * (saturationUpperLimit - saturationLowerLimit);
                buckets.removeAtIndex(index);
                numBuckets--;
                break;
            }
            index++;
        }
    }
    func transfer(from:String,to:String,amount:Double)->Bool{
        let fromBucket = self.getBucket(from)!;
        let toBucket = self.getBucket(to)!;
        if(fromBucket.availableBudget() >= amount){
            fromBucket.addTransfer(amount, desc: "Transfer to "+to, sign: -1);
            toBucket.addTransfer(amount, desc: "Transfer from "+from, sign: 1);
            return true;
        }else{
            return false;
        }
        
    }
    
    func loadTransactionData(name:String, amount:Double, desc:String, type:Int, sign:Int){
        self.getBucket(name)!.addTransaction(amount, desc: desc, sign: sign, type: type);
        if(type == 0){
            self.currentSpending += amount;
            self.currentSaturation = saturationLowerLimit + CGFloat(currentSpending / totalLimit) * (saturationUpperLimit - saturationLowerLimit);
        }
    }
    
    func addNewTransaction(name:String, amount:Double, desc:String)->Bool{
        if(self.getBucket(name)!.addtoBalance(amount, desc:desc)){
            self.currentSpending += amount;
            self.currentSaturation = saturationLowerLimit + CGFloat(currentSpending / totalLimit) * (saturationUpperLimit - saturationLowerLimit);
            return true;
        }else{
            return false;
        }
    }
    
    func getColorWithBucket(name:String) -> UIColor?{
        return self.getBucket(name)!.getColor();
    }
    
    func getLimitWithBucket(name:String) -> Double?{
        return self.getBucket(name)!.getLimit();
    }
    
    func getSpendingWithBucket(name:String) -> Double?{
        return self.getBucket(name)!.currentBalance();
    }
}
