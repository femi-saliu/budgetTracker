//
//  BucketAddView.swift
//  Test
//
//  Created by Zehao Zhang on 15/4/13.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

protocol BucketAddProtocol{
    func addTransaction(amt:Double, desc:String, type:Int)->Bool;
    func cancel();
    func characterOverFlow();
    func overBudget();
}

class BucketAddView:UIView, UITextFieldDelegate {
    let viewAlpha:CGFloat = 0.4;
    let numFrames:CGFloat = 7;
    let frameMargin:CGFloat = 0.1;
    let subFrameGap:CGFloat = 3;
    var frameX:CGFloat = 0;
    var frameY:CGFloat = 0;
    var subFrames = [CGRect]();
    var delegate:BucketAddProtocol!
    
    var amountLabel = UILabel();
    var amountField = UITextField();
    var descriptionLabel = UILabel();
    var descriptionField = UITextField();
    @IBOutlet var doneButton:UIButton!;
    @IBOutlet var cancelButton:UIButton!;
    
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
    
    func makeFrames(numFrames:CGFloat, motherFrame:CGRect){
        var subFrameH = motherFrame.height / numFrames;
        var numFramesInt = Int(numFrames);
        var currentFrameY:CGFloat = frameY;
        for(var i = 0; i < numFramesInt; i++){
            if(i != numFramesInt-1){
                subFrames.append(CGRect(x: frameX, y: currentFrameY, width: motherFrame.width, height: subFrameH));
                currentFrameY += subFrameH;
            }else{
                subFrames.append(CGRect(x: frameX, y: currentFrameY, width: motherFrame.width / 2, height: subFrameH));
                subFrames.append(CGRect(x: frameX + motherFrame.width/2, y: currentFrameY, width: motherFrame.width/2, height: subFrameH));
            }
        }
    }
    
    func setUpView(){
        self.amountLabel = UILabel(frame: subFrames[0]);
        self.amountLabel.text = "Transaction Amount";
        self.amountLabel.textAlignment = .Center;
        self.amountLabel.textColor = UIColor.whiteColor();
        
        self.amountField = UITextField(frame: subFrames[1]);
        self.amountField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: viewAlpha);
        //self.amountField.alpha = viewAlpha;
        self.amountField.delegate = self;
        self.amountField.keyboardType = UIKeyboardType.NumberPad;
        self.amountField.keyboardAppearance = UIKeyboardAppearance.Dark;
        
        self.descriptionLabel = UILabel(frame: subFrames[2]);
        self.descriptionLabel.text = "Description (Optional)";
        self.descriptionLabel.textColor = UIColor.whiteColor();
        self.descriptionLabel.textAlignment = .Center;
        
        self.descriptionField = UITextField(frame: subFrames[3]);
        self.descriptionField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: viewAlpha);
        //self.descriptionField.alpha = viewAlpha;
        self.descriptionField.delegate = self;
        self.descriptionField.keyboardType = UIKeyboardType.ASCIICapable;
        self.descriptionField.keyboardAppearance = UIKeyboardAppearance.Dark;
        
        self.doneButton = UIButton(frame: subFrames[6]);
        self.doneButton.setTitle("Done", forState: .Normal);
        //self.doneButton.backgroundColor = UIColor.whiteColor();
        self.doneButton.addTarget(self, action: "doneTapped:", forControlEvents: UIControlEvents.TouchUpInside);
        
        self.cancelButton = UIButton(frame: subFrames[7]);
        self.cancelButton.setTitle("Cancel", forState: .Normal);
        //self.cancelButton.backgroundColor = UIColor.whiteColor();
        self.cancelButton.addTarget(self, action: "cancelTapped:", forControlEvents: UIControlEvents.TouchUpInside);
        
        self.addSubview(amountLabel);
        self.addSubview(amountField);
        self.addSubview(descriptionLabel);
        self.addSubview(descriptionField);
        self.addSubview(doneButton);
        self.addSubview(cancelButton);
    }
    
    @IBAction func cancelTapped(sender:AnyObject){
        self.delegate.cancel();
    }
    
    @IBAction func doneTapped(sender:AnyObject){
        var amount = (self.amountField.text as NSString).doubleValue;
        var desc = self.descriptionField.text;
        if(desc == ""){
            desc = "N/A";
        }
        if(count(self.descriptionField.text) < 15){
            if(self.delegate.addTransaction(amount, desc: desc, type:0)){
                self.amountField.text = "";
                self.descriptionField.text = "";
            }else{
                self.delegate.overBudget();
            }
        }else{
            self.delegate.characterOverFlow();
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event);
        amountField.resignFirstResponder();
        descriptionField.resignFirstResponder();
    }
    
    func textFieldShouldReturn(input: UITextField!) -> Bool {
        input.resignFirstResponder()
        return true;
    }
    
}
