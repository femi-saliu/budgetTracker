//
//  TransactionCell.swift
//  Test
//
//  Created by Zehao Zhang on 15/4/13.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

class TransactionCell: UIButton {
    var title:String = "";
    var currentSpending:Double = 0;
    var amount:Double = 0;
    var nameLabel:UILabel = UILabel();
    var amountLabel:UILabel = UILabel();
    let defaultTextColor = UIColor.blackColor();
    
    var currentColor:UIColor = UIColor.whiteColor();
    
    var blurView:UIVisualEffectView!;
    var deleteMessage:UILabel!;
    
    init(title: String, amount:Double, frame:CGRect, sign:Double) {
        let amountx:CGFloat = 0;
        let titlex:CGFloat = frame.width / 2;
        let labely:CGFloat = 0;
        let labelw = frame.width / 2;
        let labelh = frame.height;
        self.title = title;
        self.amount = amount;
        nameLabel = UILabel(frame:CGRect(x: titlex, y: labely, width: labelw, height: labelh));
        amountLabel = UILabel(frame:CGRect(x: amountx, y: labely, width: labelw, height: labelh));
        
        var deleteFrame = CGRect(x: amountx, y: labely, width: frame.width, height: frame.height);
        
        self.deleteMessage = UILabel(frame:deleteFrame);
        self.deleteMessage.backgroundColor = UIColor.blackColor();
        self.deleteMessage.alpha = 0.7;
        self.deleteMessage.text = "Tap to delete";
        self.deleteMessage.textAlignment = NSTextAlignment.Center;
        
        super.init(frame: frame);
        
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5);
        
        self.addSubview(nameLabel);
        self.addSubview(amountLabel);
        
        nameLabel.text = title;
        nameLabel.font = UIFont(name: "Helvetica",
            size: 16.0)
        nameLabel.textAlignment = NSTextAlignment.Center;
        nameLabel.textColor = defaultTextColor;
        nameLabel.alpha = 1;
        nameLabel.adjustsFontSizeToFitWidth = true;
        if(sign == -1){
            amountLabel.text = String(format:"-%.02f", amount);
        }else{
            amountLabel.text = String(format:"+%.02f", amount);
        }
        
        amountLabel.font = UIFont(name: "Helvetica",
            size: 16.0)
        amountLabel.textAlignment = NSTextAlignment.Center;
        amountLabel.textColor = defaultTextColor;
        amountLabel.alpha = 1;
        amountLabel.adjustsFontSizeToFitWidth = true;
        
        self.addSubview(deleteMessage);
        self.deleteMessage.hidden = true;
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getName()->String {
        return title;
    }
    
    func getAmount()->Double {
        return amount;
    }
    
//    func setSpending(spend:Double){
//        currentSpending = spend;
//    }
    
//    func setColor(color:UIColor){
//        self.currentColor = color;
//        self.backgroundColor = currentColor;
//    }
    
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
