//
//  BucketView.swift
//  Test
//
//  Created by Zehao Zhang on 15/4/1.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//


/**
 UI representation of a bucket view;

 #to be implemented:
    *add delegate to enable adding/deleting transactions
**/
import UIKit

protocol BucketViewProtocol{
    func addTapped();
    func minusTapped();
}

class BucketView:UIView {
    var subFrames = [CGRect]();
    
    var topFrameProportion:CGFloat = 0.66;
    var topFrameX:CGFloat = 0;
    var topFrameY:CGFloat = 0;
    var topFrameW:CGFloat = 0;
    var topFrameH:CGFloat = 0;
    
    var midFrameY:CGFloat = 0;
    
    var botLeftFrameX:CGFloat = 0;
    var botRightFrameX:CGFloat = 0;
    var botFrameY:CGFloat = 0;
    var botFrameW:CGFloat = 0;
    var botFrameH:CGFloat = 0;
    
    var nameLabel = UILabel();
    var budgetLabel = UILabel();
    
    var delegate:BucketViewProtocol!;
    
    @IBOutlet var addButton:UIButton!;
    @IBOutlet var minusButton:UIButton!;
    
    override init(frame:CGRect) {
        super.init(frame: frame);
        self.setUpFrames(frame);
        self.setUpContent();
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpFrames(frame:CGRect){
        self.topFrameH = frame.height * topFrameProportion * 0.5;
        self.topFrameW = frame.width;
        
        self.midFrameY = frame.height * topFrameProportion * 0.5;
        
        self.botRightFrameX = frame.width * 0.5;
        self.botFrameY = frame.height * topFrameProportion;
        self.botFrameH = frame.height * (1 - topFrameProportion);
        self.botFrameW = frame.width * 0.5;
        
        subFrames.append(CGRect(x: topFrameX, y: topFrameY, width: topFrameW, height: topFrameH));
        subFrames.append(CGRect(x: topFrameX, y: midFrameY, width: topFrameW, height: topFrameH));
        subFrames.append(CGRect(x: botLeftFrameX, y: botFrameY, width: botFrameW, height: botFrameH));
        subFrames.append(CGRect(x: botRightFrameX, y: botFrameY, width: botFrameW, height: botFrameH));
    }
    
    func setUpContent(){
        self.addButton = UIButton(frame: subFrames[2]);
        self.minusButton = UIButton(frame: subFrames[3]);
        self.nameLabel = UILabel(frame: subFrames[0]);
        self.budgetLabel = UILabel(frame: subFrames[1]);
        
        self.nameLabel.textAlignment = NSTextAlignment.Center;
        self.budgetLabel.textAlignment = NSTextAlignment.Center;
        self.nameLabel.font = UIFont(name: "Helvetica", size: 35);
        self.budgetLabel.font = UIFont(name: "Helvetica", size: 40);
        
        self.nameLabel.adjustsFontSizeToFitWidth = true;
        self.budgetLabel.adjustsFontSizeToFitWidth = true;
        
        self.addSubview(nameLabel);
        self.addSubview(budgetLabel);
        
        addButton.setTitle("+", forState: UIControlState.Normal);
        addButton.titleLabel?.font = UIFont(name: "Helvetica", size: 50);
        addButton.backgroundColor = UIColor.whiteColor();
        addButton.alpha = 0.5;
        addButton.addTarget(self, action: "addTapped:", forControlEvents: .TouchUpInside);
        self.addSubview(addButton);
        
        
        minusButton.setTitle("-", forState: UIControlState.Normal);
        minusButton.titleLabel?.font = UIFont(name: "Helvetica", size: 50);
        minusButton.backgroundColor = UIColor.whiteColor();
        minusButton.alpha = 0.5;
        minusButton.addTarget(self, action: "minusTapped:", forControlEvents: .TouchUpInside);
        self.addSubview(minusButton);
    }
    
    func setColor(color:UIColor){
        self.backgroundColor = color;
        self.addButton.setTitleColor(color, forState: UIControlState.Normal);
        self.minusButton.setTitleColor(color, forState: UIControlState.Normal);
    }
    
    func setTitle(name:String){
        self.nameLabel.text = name;
    }
    
    func setSpending(limit:Double, spending:Double){
        self.budgetLabel.text = String(format:"%.02f / %.02f", spending, limit);
    }
    
    func setCancelMinus(){
        self.minusButton.setTitle("Cancel", forState: .Normal);
        minusButton.titleLabel?.font = UIFont(name: "Helvetica", size: 30);
    }
    
    func setOriginalMinus(){
        self.minusButton.setTitle("-", forState: .Normal);
        minusButton.titleLabel?.font = UIFont(name: "Helvetica", size: 50);
    }
    
    @IBAction func addTapped(sender:AnyObject){
        self.delegate.addTapped();
    }
    
    @IBAction func minusTapped(sender:AnyObject){
                self.delegate.minusTapped();
    }
}
