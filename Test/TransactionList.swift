//
//  TransactionList.swift
//  Test
//
//  Created by Zehao Zhang on 15/4/13.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

protocol TransactionCellProtocol{
    func transactionTapped(sender:TransactionCell);
    func transactionDeleted(name:String, amt:Double);
}

class TransactionList:UIScrollView {
    let cellGap:CGFloat = 0.1;
    let cellsPerView:CGFloat = 6;
    var currentYOff:CGFloat = 0;
    var frameWidth:CGFloat = 0;
    var bucketFrameY:CGFloat = 0;
    var buckets = [TransactionCell]();
    var bucketFrameX:CGFloat = 0;
    var bucketFrameW:CGFloat = 0;
    var bucketFrameH:CGFloat = 0;
    var currentContentHeight:CGFloat = 0;
    var viewStart:CGFloat = 0;
    var transactionCellDelegate:TransactionCellProtocol?
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
    
    func addNewTransaction(desc:String,amount:Double, type:Int){
        println("add transaction");
        var newFrame = CGRect(x: bucketFrameX, y: bucketFrameY, width: bucketFrameW, height: bucketFrameH);
        var newCell = TransactionCell(title:desc, amount:amount, frame:newFrame, tag: cellCount, type:type);
        
        buckets.append(newCell);

        self.addSubview(newCell);
        cellCount++;
        
        currentYOff += bucketFrameH;
        bucketFrameY = viewStart + currentYOff;
        self.currentContentHeight += bucketFrameH;
        self.contentSize = CGSize(width:frameWidth, height:currentContentHeight);
        newCell.addTarget(self, action: "cellSelected:", forControlEvents: UIControlEvents.TouchUpInside);
    }
    
    func getTransaction(name:String) -> TransactionCell?{
        var index = 0;
        for bucket in buckets{
            if(bucket.getName() == name){
                return bucket;
            }
        }
        return nil;
    }
    
//    func setBucketColorWithName(name:String, color:UIColor){
//        self.getBucket(name)?.setColor(color);
//    }
    
    func setDeleteMode(inDeleteMode:Bool){
        for bucket in buckets{
            bucket.deleteMode(inDeleteMode);
        }
    }
    
    @IBAction func deleteTransactionCell(sender:TransactionCell){
        println("delete");
        if(sender.getType()==0){
            self.transactionCellDelegate?.transactionDeleted(sender.getName(), amt:sender.getAmount());
            var index = 0;
            var found = false;
            var tagNum = sender.getTag();
            for bucket in buckets{
                if(bucket.getTag()==tagNum){
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
                    })
                }
            }
            bucketFrameY -= bucketFrameH;
            currentYOff -=  bucketFrameH;
            cellCount--;
            self.currentContentHeight -= bucketFrameH;
            self.contentSize = CGSize(width:frameWidth, height:currentContentHeight);
        }
    }
    
    @IBAction func cellSelected(sender: AnyObject){
        let transactionCell = sender as TransactionCell;
        self.transactionCellDelegate!.transactionTapped(transactionCell);
    }
    
}
