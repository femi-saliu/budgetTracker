//
//  TrackerModel.swift
//  Test
//
//  Created by Zehao Zhang on 15/3/11.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import Foundation
import UIKit

class TrackerModel {
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
    
    func setTotalBudget(totalBudget:Double){
        totalLimit = totalBudget;

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
                buckets.removeAtIndex(index);
                numBuckets--;
                break;
            }
            index++;
        }
    }
    func transfer(from:BucketModel,to:BucketModel,amount:Double){
        if(from.getLimit() > amount){
            from.addToLimit(-amount);
            to.addToLimit(amount);
        }
        
    }
    
    func addNewTransaction(name:String, amount:Double)->Bool{
        if(self.getBucket(name)!.addtoBalance(amount)){
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
