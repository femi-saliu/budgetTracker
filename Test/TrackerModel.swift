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
    
//    init(){
//    
//    }
    
    func setTotalBudget(totalBudget:Double){
        totalLimit = totalBudget;

    }
        
    func addNewBucket(name:String, limit:Double, hue:CGFloat) -> Bool{ // Add color of the bucket later
        for bucket in buckets{
            if(bucket.getName() == name){
                return false;
            }
        }
        var newBucket:BucketModel;
        newBucket = BucketModel(n:name,newlimit:limit, hue:hue);
        buckets.append(newBucket);
        numBuckets++;
        return true;
    }
    
    func removeBucket(name:String){
        var index = 0;
        for bucket in buckets{
            if(bucket.getName()==name){
                buckets.removeAtIndex(index);
                break;
            }
            index++;
        }
    }
    func transfer(from:BucketModel,to:BucketModel,amount:Double){
        if(from.getLimit() > amount){
            from.setLimit(from.getLimit() - amount);
            to.setLimit(to.getLimit() + amount);
        }
        
    }
    
    
}
