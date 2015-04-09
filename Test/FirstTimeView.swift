//
//  FirstTimeView.swift
//  Test
//
//  Created by Zehao Zhang on 15/4/8.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

protocol SetUpProtocol {
    func setTotalBudget(totalBudget: Double);
}

class FirstTimeView: UIView,UITextFieldDelegate {
    
    let viewAlpha:CGFloat = 0.5;
    let numFrames:CGFloat = 4;
    let frameMargin:CGFloat = 0.1;
    var frameX:CGFloat = 0;
    var frameY:CGFloat = 0;
    //var subFrameH:CGFloat = 0;
    var subFrames = [CGRect]();
    
    var delegate:SetUpProtocol!;

    var budgetField:UITextField = UITextField();
    var budgetLabel:UILabel = UILabel();
    
    @IBOutlet var doneButton:UIButton!
    
    override init(frame:CGRect) {
        super.init(frame: frame);
        self.frameX = frame.width * frameMargin;
        self.frameY = frame.height * frameMargin;
        let subFrame = CGRect(x: frameX, y: frameY, width: frame.width * (1 - 2 * frameMargin), height: frame.height * (1 - 2 * frameMargin));
        self.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 1, alpha: viewAlpha);
        self.makeFrames(numFrames, motherFrame: frame);
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func makeFrames(numFrames:CGFloat, motherFrame:CGRect){
        var subFrameH = motherFrame.height / numFrames;
        var numFramesInt = Int(numFrames);
        var currentFrameY:CGFloat = frameY;
        for(var i = 0; i < numFramesInt; i++){
            subFrames.append(CGRect(x: frameX, y: currentFrameY, width: motherFrame.width, height: subFrameH));
            currentFrameY += subFrameH;
        }
    }
    
    func setUpView(frames:[CGRect]){
        
        self.budgetLabel = UILabel(frame:frames[0]);
        self.budgetLabel.text = "Budget";
        self.budgetLabel.textAlignment = NSTextAlignment.Center;
        self.budgetLabel.textColor = UIColor.whiteColor();
        
        self.budgetField = UITextField(frame: frames[1]);
        self.budgetField.backgroundColor = UIColor.whiteColor();
        self.budgetField.delegate = self;
        self.budgetField.keyboardType = UIKeyboardType.NumberPad;
        
        self.doneButton = UIButton(frame: frames[3]);
        self.doneButton.setTitle("Done", forState: UIControlState.Normal);
        self.doneButton.addTarget(self, action: "done:", forControlEvents: UIControlEvents.TouchUpInside);
        
        self.addSubview(budgetLabel);
        self.addSubview(budgetField);
        self.addSubview(doneButton);
    }
    
    func textFieldShouldReturn(input: UITextField!) -> Bool {
        input.resignFirstResponder()
        return true;
    }
    
    @IBAction func done(sender: AnyObject){
        var budgetDouble:Double = (budgetField.text as NSString).doubleValue;
        //self.delegate!.addBucketCell(nameField.text, budget: budgetDouble, hue:hueValue);
        self.delegate!.setTotalBudget(budgetDouble);
        self.budgetField.text = "";
    }
    
    
}
