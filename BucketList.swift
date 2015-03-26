//
//  BucketList.swift
//  Test
//
//  Created by Zehao Zhang on 15/3/24.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

class BucketList:UIScrollView {
    var currentYOff:CGFloat = 0.0;
    var bucketFrameY:CGFloat = 0.0;
    var buckets = [BucketCell]();
    var bucketFrameX:CGFloat = 0;
    var bucketFrameH:CGFloat = 0;
    var bucketFrameW:CGFloat = 0;
    var viewStart:CGFloat?
    
    override init(frame:CGRect) {
        self.bucketFrameW = frame.width;
        self.bucketFrameH = frame.height/4;
        self.bucketFrameX = frame.origin.x;
        self.viewStart = 0;
        super.init(frame: frame);
        //self.backgroundColor = UIColor.whiteColor();
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addNewBucket(name:String,limit:Double){
        println("add");
        bucketFrameY = viewStart! + currentYOff;
        var newCell = BucketCell(title:name, limit:limit, frame:CGRect(x: bucketFrameX, y: bucketFrameY, width: bucketFrameW, height: bucketFrameH));
        buckets.append(newCell);
        self.addSubview(newCell);
        //newCell.addTarget(self, action: "deleteBucketCell:name", forControlEvents: UIControlEvents.TouchUpInside);
        currentYOff += bucketFrameH;
    }
    
    func deleteBucketCell(name:String){
        println("delete");
        var index = 0;
        var found = false;
        for bucket in buckets{
            if(bucket.getName()==name){
                buckets[index].removeFromSuperview();
                buckets.removeAtIndex(index);
                found = true;
                break;
            }
            index++;
        }
        if(found){
            for(var i = index+1; i < buckets.count; i++){
                UIView.animateWithDuration(0.7, delay: 1.0, options: .CurveEaseOut, animations: {
                    var bucketFrame = self.buckets[i].frame;
                    bucketFrame.origin.y -= self.bucketFrameW;
                    
                    self.buckets[i].frame = bucketFrame;
                    }, completion: { finished in
                        println("Buckets moved")
                })
                buckets[i-1] = buckets[i];
            }
            buckets.removeLast();
        }
        
    }
    
}