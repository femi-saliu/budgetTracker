//
//  TrackerModel.swift
//  Test
//
//  Created by Zehao Zhang on 15/3/11.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import Foundation

class TrackerModel {
    var buckets = [BucketModel]();
    var totalLimit:Double;
    var numBuckets=0;
    
    init(totalBudget:Double){
        totalLimit = totalBudget;
    }
        
    func addNewBucket(name:String, limit:Double){ // Add color of the bucket later
        var newBucket:BucketModel;
        newBucket = BucketModel(n:name,newlimit:limit);
        buckets.append(newBucket);
        numBuckets++;
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
