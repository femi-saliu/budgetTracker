//
//  AddOptionsView.swift
//  Test
//
//  Created by Zehao Zhang on 15/3/30.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

protocol addOptionsProtocol{
    func addBucketCell(name:String, budget:Double, hue: CGFloat)->Bool;
    func cancelAddOption();
    func emptyAlert();
}

class AddOptionsView:UIView, UITextFieldDelegate{
    let viewAlpha:CGFloat = 0.4;
    let numFrames:CGFloat = 7;
    let frameMargin:CGFloat = 0.1;
    var frameX:CGFloat = 0;
    var frameY:CGFloat = 0;
    var subFrames = [CGRect]();
    var nameField:UITextField = UITextField();
    var budgetField:UITextField = UITextField();
    var nameLabel:UILabel = UILabel();
    var budgetLabel:UILabel = UILabel();
    var colorLabel:UILabel = UILabel();
    var delegate:addOptionsProtocol! = nil
    
    let initBrightness:CGFloat = CGFloat(100) / 100;
    let initSaturation:CGFloat = CGFloat(100) / 100;
    let initAlpha:CGFloat = CGFloat(1);
    
    var hueValue:CGFloat = 0;
    
    @IBOutlet var doneButton:UIButton!
    @IBOutlet var cancelButton:UIButton!
    @IBOutlet var colorSlider:UISlider!
    
    override init(frame:CGRect) {
        super.init(frame: frame);
        self.frameX = frame.width * frameMargin;
        self.frameY = frame.height * frameMargin;
        let subFrame = CGRect(x: frameX, y: frameY, width: frame.width * (1 - 2 * frameMargin), height: frame.height * (1 - 2 * frameMargin));
        self.makeFrames(numFrames, motherFrame: subFrame);
        self.setUpView(subFrames);
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
    
    func setUpView(frames:[CGRect]){
        self.nameLabel = UILabel(frame: frames[0]);
        self.nameLabel.text = "Bucket Name";
        self.nameLabel.textAlignment = NSTextAlignment.Center;
        self.nameLabel.textColor = UIColor.whiteColor();
        self.nameLabel.adjustsFontSizeToFitWidth = true;
        
        self.nameField = UITextField(frame: frames[1]);
        self.nameField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: viewAlpha);
        self.nameField.delegate = self;
        self.nameField.keyboardType = UIKeyboardType.ASCIICapable;
        self.nameField.keyboardAppearance = UIKeyboardAppearance.Dark;
        
        self.budgetLabel = UILabel(frame:frames[2]);
        self.budgetLabel.text = "Enter a Budget";
        self.budgetLabel.textAlignment = NSTextAlignment.Center;
        self.budgetLabel.textColor = UIColor.whiteColor();
        self.budgetLabel.adjustsFontSizeToFitWidth = true;
        
        self.budgetField = UITextField(frame: frames[3]);
        self.budgetField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: viewAlpha);
        self.budgetField.delegate = self;
        self.budgetField.keyboardType = UIKeyboardType.NumberPad;
        self.budgetField.keyboardAppearance = UIKeyboardAppearance.Dark;
        
        self.colorLabel = UILabel(frame:frames[4]);
        self.colorLabel.text = "$ Color $";
        self.colorLabel.textAlignment = NSTextAlignment.Center;
        self.colorLabel.adjustsFontSizeToFitWidth = true;
        
        self.colorSlider = UISlider(frame: frames[5]);
        self.colorSlider.maximumValue = 9;
        self.colorSlider.minimumValue = 0;
        self.colorSlider.addTarget(self, action: "sliderAction:", forControlEvents: UIControlEvents.ValueChanged);
        
        hueValue = CGFloat(Int(colorSlider.value)) / 10;
        var colorTextColor:UIColor = UIColor(hue: hueValue, saturation: initSaturation, brightness: initBrightness, alpha: initAlpha);
        self.colorLabel.textColor = colorTextColor;
        
        self.doneButton = UIButton(frame: frames[6]);
        self.doneButton.setTitle("Done", forState: UIControlState.Normal);
        self.doneButton.addTarget(self, action: "done:", forControlEvents: UIControlEvents.TouchUpInside);
        
        self.cancelButton = UIButton(frame: frames[7]);
        self.cancelButton.setTitle("Cancel", forState: UIControlState.Normal);
        self.cancelButton.addTarget(self, action: "cancel:", forControlEvents: UIControlEvents.TouchUpInside);
        
        self.addSubview(nameLabel);
        self.addSubview(nameField);
        self.addSubview(budgetLabel);
        self.addSubview(budgetField);
        self.addSubview(colorLabel);
        self.addSubview(colorSlider);
        self.addSubview(cancelButton);
        self.addSubview(doneButton);
    }
    
    func setAvailableAmt(amt: Double){
        budgetLabel.text = String(format:"Budget (%.02f left)", amt);
    }
    
    func textFieldShouldReturn(input: UITextField) -> Bool {
        input.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event);
        budgetField.resignFirstResponder();
        nameField.resignFirstResponder();
    }
    
    @IBAction func done(sender: AnyObject){
        if(self.budgetField.text == "" || self.nameField.text == "" || (budgetField.text as NSString).doubleValue == 0){
            self.delegate.emptyAlert();
        }else{
            var budgetDouble:Double = (budgetField.text as NSString).doubleValue;
            if(self.delegate!.addBucketCell(nameField.text, budget: budgetDouble, hue:hueValue)){
                self.budgetField.text = "";
                self.nameField.text = "";
            }
        }
    }
    
    @IBAction func cancel(sender: AnyObject){
        self.delegate!.cancelAddOption();
    }
    
    @IBAction func sliderAction(sender:AnyObject){
        hueValue = CGFloat(Int(colorSlider.value)) / 10;
        var colorTextColor:UIColor = UIColor(hue: hueValue, saturation: initSaturation, brightness: initBrightness, alpha: initAlpha);
        self.colorLabel.textColor = colorTextColor;
    }
}
