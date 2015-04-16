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
        
        self.deleteMessage = UILabel(frame:deleteFrame);
        self.deleteMessage.backgroundColor = UIColor.blackColor();
        self.deleteMessage.alpha = 0.7;
        self.deleteMessage.text = "Tap to delete";
        self.deleteMessage.textAlignment = NSTextAlignment.Center;
        
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
        self.deleteMessage.hidden = true;
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
    
    func deleteMode(inDeleteMode:Bool){
        if(inDeleteMode){
            self.deleteMessage.textColor = currentColor;
        }
        UIView.animateWithDuration(0.7, delay: 0.2, options: .ShowHideTransitionViews, animations: {
            self.deleteMessage.hidden = !inDeleteMode;
            }, completion: { finished in
        })
        
    }
}
