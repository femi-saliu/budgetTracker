//
//  BucketCell.swift
//  Test
//
//  Created by Zehao Zhang on 15/3/24.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit


class BucketCell: UIButton {
    var title:String = "";
    var currentSpending:Double = 0;
    var limit:Double = 0;
    var nameLabel:UILabel = UILabel();
    var limitLabel:UILabel = UILabel();
    let defaultTextColor = UIColor.blackColor();
    
    var currentColor:UIColor = UIColor.whiteColor();
    
    var blurView:UIVisualEffectView!;
    var deleteMessage:UILabel!;
    var transferFromMessage:UILabel!;
    var transferToMessage:UILabel!;
    
    var deleteString = "Tap to delete bucket";
    var transferFromString = "Tap to select transfer from bucket";
    var transferToString = "Tap to select transfer to bucket";
    
    init(title: String, limit:Double, frame:CGRect) {
        let titlex:CGFloat = 0;
        let limitx:CGFloat = frame.width / 2;
        let labely:CGFloat = 0;
        let labelw = frame.width / 2;
        let labelh = frame.height;
        self.title = title;
        self.limit = limit;
        nameLabel = UILabel(frame:CGRect(x: titlex, y: labely, width: labelw, height: labelh));
        limitLabel = UILabel(frame:CGRect(x: limitx, y: labely, width: labelw, height: labelh));
        
        var messageFrame = CGRect(x: titlex, y: labely, width: frame.width, height: frame.height);
        
        self.deleteMessage = UILabel(frame:messageFrame);
        self.deleteMessage.backgroundColor = UIColor.blackColor();
        self.deleteMessage.alpha = 0.7;
        self.deleteMessage.text = "Tap to delete bucket";
        self.deleteMessage.textAlignment = NSTextAlignment.Center;
        
        self.transferFromMessage = UILabel(frame:messageFrame);
        self.transferFromMessage.backgroundColor = UIColor.blackColor();
        self.transferFromMessage.alpha = 0.7;
        self.transferFromMessage.text = "Tap to select transfer from bucket";
        self.transferFromMessage.textAlignment = NSTextAlignment.Center;
        
        self.transferToMessage = UILabel(frame:messageFrame);
        self.transferToMessage.backgroundColor = UIColor.blackColor();
        self.transferToMessage.alpha = 0.7;
        self.transferToMessage.text = "Tap to select transfer to bucket";
        self.transferToMessage.textAlignment = NSTextAlignment.Center;
        
        super.init(frame: frame);
        
        self.addSubview(nameLabel);
        self.addSubview(limitLabel);
        
        nameLabel.text = title;
        nameLabel.font = UIFont(name: "Helvetica",
            size: 16.0)
        nameLabel.textAlignment = NSTextAlignment.Center;
        nameLabel.textColor = defaultTextColor;
        nameLabel.alpha = 1;
        nameLabel.adjustsFontSizeToFitWidth = true;
        limitLabel.text = String(format:"%.02f / %.02f", currentSpending, limit);
        limitLabel.font = UIFont(name: "Helvetica",
            size: 16.0)
        limitLabel.textAlignment = NSTextAlignment.Center;
        limitLabel.textColor = defaultTextColor;
        limitLabel.alpha = 1;
        limitLabel.adjustsFontSizeToFitWidth = true;
        
        self.addSubview(deleteMessage);
        self.addSubview(transferFromMessage);
        self.addSubview(transferToMessage);
        self.deleteMessage.hidden = true;
        self.transferFromMessage.hidden = true;
        self.transferToMessage.hidden = true;
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getName()->String {
        return title;
    }
    
    func setSpending(spend:Double){
        currentSpending = spend;
        limitLabel.text = String(format:"%.02f / %.02f", currentSpending, limit);
    }
    
    func setCurrentLimit(l:Double){
        self.limit = l;
        limitLabel.text = String(format:"%.02f / %.02f", currentSpending, limit);
    }
    
    func setColor(color:UIColor){
        self.currentColor = color;
        self.backgroundColor = currentColor;
    }
    
    func transferMode(mode:Int){
        self.deleteMessage.hidden = true;
        if(mode == 0){
            self.transferFromMessage.hidden = true;
            self.transferToMessage.hidden = true;
        }else if(mode == 1){
            self.transferFromMessage.textColor = currentColor;
            self.transferToMessage.hidden = true;
            self.transferFromMessage.hidden = false;
        }else{
            self.transferToMessage.textColor = currentColor;
            self.transferFromMessage.hidden = true;
            self.transferToMessage.hidden = false;
        }
    }
    
    func deleteMode(inDeleteMode:Bool){
        if(inDeleteMode){
            self.deleteMessage.textColor = currentColor;
            self.transferFromMessage.hidden = true;
            self.transferToMessage.hidden = true;
        }
        UIView.animateWithDuration(0.7, delay: 0.2, options: .ShowHideTransitionViews, animations: {
            self.deleteMessage.hidden = !inDeleteMode;
            }, completion: { finished in
        })
        
    }
    
    func transferDone(){
        self.transferToMessage.hidden = true;
        self.transferFromMessage.hidden = true;
    }
}
