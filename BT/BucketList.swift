//
//  BucketList.swift
//  Test
//
//  Created by Zehao Zhang on 15/3/24.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

protocol bucketCellProtocol{
    func bucketTapped(sender:BucketCell);
}

class BucketList:UIScrollView {
    let cellGap:CGFloat = 0.1;
    let cellsPerView:CGFloat = 6;
    var currentYOff:CGFloat = 0;
    var frameWidth:CGFloat = 0;
    var bucketFrameY:CGFloat = 0;
    var buckets = [BucketCell]();
    var bucketFrameX:CGFloat = 0;
    var bucketFrameW:CGFloat = 0;
    var bucketFrameH:CGFloat = 0;
    var currentContentHeight:CGFloat = 0;
    var viewStart:CGFloat = 0;
    var bucketCellDelegate:bucketCellProtocol?
    //var cells = [CGRect]();
    var cellCount = 0;
    
    override init(frame:CGRect) {
        //self.gapSize = frame.width * cellGap;
        self.bucketFrameW = frame.width;
        self.viewStart = 0;
        self.frameWidth = frame.width;
        self.bucketFrameH = frame.height / cellsPerView;
        self.currentContentHeight = bucketFrameH;
        super.init(frame: frame);
        self.contentSize = CGSize(width:frameWidth, height:currentContentHeight);
        //self.backgroundColor = UIColor.whiteColor();
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addNewBucket(name:String,limit:Double){
        println("add");
        var newFrame = CGRect(x: bucketFrameX, y: bucketFrameY, width: bucketFrameW, height: bucketFrameH);
        var newCell = BucketCell(title:name, limit:limit, frame:newFrame);
        //newCell.addTarget(self, action: "deleteBucketCell:", forControlEvents: UIControlEvents.TouchUpInside);
        buckets.append(newCell);
        //cells.append(newFrame);
        self.addSubview(newCell);
        cellCount++;
        
        currentYOff += bucketFrameH;
        bucketFrameY = viewStart + currentYOff;
        self.currentContentHeight += bucketFrameH;
        self.contentSize = CGSize(width:frameWidth, height:currentContentHeight);
        newCell.addTarget(self, action: "bucketSelected:", forControlEvents: UIControlEvents.TouchUpInside);
    }
    
    func getBucket(name:String) -> BucketCell?{
        var index = 0;
        for bucket in buckets{
            if(bucket.getName() == name){
                return bucket;
            }
        }
        return nil;
    }
    
    func setBucketColorWithName(name:String, color:UIColor){
        self.getBucket(name)?.setColor(color);
    }
    
    func setBucketSpendingWithName(name:String, s:Double){
        self.getBucket(name)?.setSpending(s);
    }
    
    func setBucketLimitWithName(name:String, l:Double){
        self.getBucket(name)!.setCurrentLimit(l);
    }
    
    func setDeleteMode(inDeleteMode:Bool){
        for bucket in buckets{
            bucket.deleteMode(inDeleteMode);
        }
    }
    
    func setTransferFromWithName(name:String){
        self.getBucket(name)!.setTransferFromBucket();
    }
    
    func isTransferFromWithName(name:String)->Bool{
       return self.getBucket(name)!.isTransferFromBucket();
    }
    
    func resetTransferFromWithName(name:String){
        self.getBucket(name)!.resetTransferFrom();
    }
    
    func setTransferMode(mode:Int){
        for bucket in buckets{
            bucket.transferMode(mode);
        }
    }
    
    func setTransferDone(){
        for bucket in buckets{
            bucket.transferDone();
        }
    }
    
    @IBAction func deleteBucketCell(sender:BucketCell){
        println("delete");
        var index = 0;
        var found = false;
        var name = sender.getName();
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
            for(var i = index; i < buckets.count; i++){
                UIView.animateWithDuration(0.7, delay: 0.2, options: .CurveEaseOut, animations: {
                    var bucketFrame = self.buckets[i].frame;
                    bucketFrame.origin.y -= self.bucketFrameH;
                    
                    self.buckets[i].frame = bucketFrame;
                    }, completion: { finished in
                        //println("Buckets moved")
                })
                //buckets[i-1] = buckets[i];
            }
            //buckets.removeLast();
        }
        bucketFrameY -= bucketFrameH;
        currentYOff -=  bucketFrameH;
        cellCount--;
        self.currentContentHeight -= bucketFrameH;
        self.contentSize = CGSize(width:frameWidth, height:currentContentHeight);
    }
    
    @IBAction func bucketSelected(sender: AnyObject){
        let bucketCell = sender as BucketCell;
        self.bucketCellDelegate!.bucketTapped(bucketCell);
    }
    
}