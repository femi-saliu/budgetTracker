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
    var message:UILabel!;
    var deleteString:String = "Tap to delete";
    var transferFromString:String = "Select transfer from";
    var transferToString:String = "Select transfer to";

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
        
        var deleteFrame = CGRect(x: titlex, y: labely, width: frame.width, height: frame.height);
        
        self.message = UILabel(frame:deleteFrame);
        self.message.backgroundColor = UIColor.blackColor();
        self.message.alpha = 0.7;
        //self.message.text = "Tap to delete";
        self.message.textAlignment = NSTextAlignment.Center;
        
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
        
        //self.addSubview(deleteMessage);
        self.message.hidden = true;
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
    
    func setColor(color:UIColor){
        self.currentColor = color;
        self.backgroundColor = currentColor;
    }
    
    func transferMode(mode:Int){
        if(mode == 0){
            self.message.hidden = true;
        }else if(mode == 1){
            self.message.text = transferFromString;
            self.message.textColor = currentColor;
            self.message.hidden = false;
        }else{
            self.message.text = transferToString;
            self.message.textColor = currentColor;
            self.message.hidden = false;
        }
    }
    
    func deleteMode(inDeleteMode:Bool){
        if(inDeleteMode){
            self.message.text = deleteString;
            self.message.textColor = currentColor;
        }
        UIView.animateWithDuration(0.7, delay: 0.2, options: .ShowHideTransitionViews, animations: {
            self.message.hidden = !inDeleteMode;
            }, completion: { finished in
        })
        
    }
}
