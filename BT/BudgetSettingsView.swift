//
//  BudgetSettingsView.swift
//  BT
//
//  Created by Zehao Zhang on 15/4/27.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

protocol SettingsProtocol{
    //func resetAllTransactions();
    func makeSureResetAllTransactions();
    //func allowOverBudget(overBudget:Bool);
    //func returnFromSettings();
    func resetTotalBudget(totalBudget:Double);
}

class BudgetSettingsView:UIView, UITextFieldDelegate {
    let viewAlpha:CGFloat = 0.4;
    let numFrames:CGFloat = 5;
    let frameMargin:CGFloat = 0.1;
    let subFrameGap:CGFloat = 3;
    var frameX:CGFloat = 0;
    var frameY:CGFloat = 0;
    var subFrames = [CGRect]();
    var limit:Double = 0;
    var overBudget:Bool = false;
    var delegate:SettingsProtocol!
    
    var overBudgetNO = "Allow Over-budget: NO";
    var overBudgetYES = "Allow Over-budget: YES";
    
    var amountLabel = UILabel();
    var amountField = UITextField();
    @IBOutlet var clearButton:UIButton!;
    @IBOutlet var overBudgetButton:UIButton!;
    @IBOutlet var doneButton:UIButton!;
    //@IBOutlet var cancelButton:UIButton!;
    
    override init(frame:CGRect) {
        super.init(frame: frame);
        self.frameX = frame.width * frameMargin;
        self.frameY = frame.height * frameMargin;
        let subFrame = CGRect(x: frameX, y: frameY, width: frame.width * (1 - 2 * frameMargin), height: frame.height * (1 - 2 * frameMargin));
        self.makeFrames(numFrames, motherFrame: subFrame);
        self.setUpView();
        self.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 1, alpha: viewAlpha);
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setLimit(totalLimit:Double){
        self.limit = totalLimit;
        self.amountField.text = String(format:"%.02f", limit);
    }
    
    func makeFrames(numFrames:CGFloat, motherFrame:CGRect){
        var subFrameH = motherFrame.height / numFrames;
        var numFramesInt = Int(numFrames);
        var currentFrameY:CGFloat = frameY;
        for(var i = 0; i < numFramesInt; i++){
            //if(i != numFramesInt-1){
                subFrames.append(CGRect(x: frameX, y: currentFrameY, width: motherFrame.width, height: subFrameH));
                currentFrameY += subFrameH;
//            }else{
//                subFrames.append(CGRect(x: frameX, y: currentFrameY, width: motherFrame.width / 2, height: subFrameH));
//                subFrames.append(CGRect(x: frameX + motherFrame.width/2, y: currentFrameY, width: motherFrame.width/2, height: subFrameH));
//            }
        }
    }
    
    func setUpView(){
        self.amountLabel = UILabel(frame: subFrames[0]);
        self.amountLabel.text = "Transfer Balance: ";
        self.amountLabel.adjustsFontSizeToFitWidth = true;
        self.amountLabel.textAlignment = .Center;
        self.amountLabel.textColor = UIColor.whiteColor();
        
        self.amountField = UITextField(frame: subFrames[1]);
        self.amountField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: viewAlpha);
        self.amountField.text = String(format:"%.02f", limit);
        self.amountField.delegate = self;
        self.amountField.keyboardType = UIKeyboardType.NumberPad;
        self.amountField.keyboardAppearance = UIKeyboardAppearance.Dark;
        
//        self.overBudgetButton = UIButton(frame: subFrames[2]);
//        self.overBudgetButton.setTitle(overBudgetNO, forState: .Normal);
//        self.overBudgetButton.addTarget(self, action: "overBudgetTapped:", forControlEvents: .TouchUpInside);
        
        self.clearButton = UIButton(frame: subFrames[3]);
        self.clearButton.setTitle("Reset Cycle", forState: .Normal);
        self.clearButton.setTitleColor(UIColor.redColor(), forState: .Normal);
        self.clearButton.addTarget(self, action: "resetTapped:", forControlEvents: .TouchUpInside);
        
        self.doneButton = UIButton(frame: subFrames[4]);
        self.doneButton.setTitle("Done", forState: .Normal);
        self.doneButton.addTarget(self, action: "doneTapped:", forControlEvents: .TouchUpInside);
        
        self.addSubview(amountLabel);
        self.addSubview(amountField);
        //self.addSubview(overBudgetButton);
        self.addSubview(clearButton);
        self.addSubview(doneButton);
    }
    
    @IBAction func doneTapped(sender:AnyObject){
        var amount = (self.amountField.text as NSString).doubleValue;
        self.delegate.resetTotalBudget(amount);
    }
    
    @IBAction func overBudgetTapped(sender:AnyObject){
        if(overBudget){
            self.overBudgetButton.setTitle(overBudgetNO, forState: .Normal);
            self.overBudget = false;
        }else{
            self.overBudgetButton.setTitle(overBudgetYES, forState: .Normal);
            self.overBudget = true;
        }
        //self.delegate.allowOverBudget(overBudget);
    }
    
    @IBAction func resetTapped(sender:AnyObject){
        self.delegate.makeSureResetAllTransactions();
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event);
        amountField.resignFirstResponder();
    }
    
    func textFieldShouldReturn(input: UITextField!) -> Bool {
        input.resignFirstResponder()
        return true;
    }
    
}
