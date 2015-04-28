//
//  FirstTimeView.swift
//  Test
//
//  Created by Zehao Zhang on 15/4/8.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

protocol SetUpProtocol {
    func setTotalBudget(totalBudget: Double, hue: CGFloat);
    func emptyAlert();
}

class FirstTimeView: UIView,UITextFieldDelegate {
    
    let viewAlpha:CGFloat = 0.4;
    let numFrames:CGFloat = 5;
    let frameMargin:CGFloat = 0.1;
    var frameX:CGFloat = 0;
    var frameY:CGFloat = 0;
    //var subFrameH:CGFloat = 0;
    var subFrames = [CGRect]();
    
    var delegate:SetUpProtocol!;
    
    var budgetField:UITextField = UITextField();
    var budgetLabel:UILabel = UILabel();
    var colorLabel:UILabel = UILabel();
    
    let initBrightness:CGFloat = CGFloat(100) / 100;
    let initSaturation:CGFloat = CGFloat(100) / 100;
    let initAlpha:CGFloat = CGFloat(1);
    
    var hueValue:CGFloat = 0;
    
    @IBOutlet var doneButton:UIButton!
    @IBOutlet var colorSlider:UISlider!
    
    override init(frame:CGRect) {
        super.init(frame: frame);
        self.frameX = frame.width * frameMargin;
        self.frameY = frame.height * frameMargin;
        let subFrame = CGRect(x: frameX, y: frameY, width: frame.width * (1 - 2 * frameMargin), height: frame.height * (1 - 2 * frameMargin));
        self.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 1, alpha: viewAlpha);
        self.makeFrames(numFrames, motherFrame: subFrame);
        self.setUpView(subFrames);
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
        self.budgetField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: viewAlpha);
        self.budgetField.delegate = self;
        self.budgetField.keyboardType = UIKeyboardType.NumberPad;
        self.budgetField.keyboardAppearance = UIKeyboardAppearance.Dark;
        
        self.colorLabel = UILabel(frame:frames[2]);
        self.colorLabel.text = "Color: $";
        self.colorLabel.textAlignment = NSTextAlignment.Center;
        
        self.colorSlider = UISlider(frame: frames[3]);
        self.colorSlider.maximumValue = 9;
        self.colorSlider.minimumValue = 0;
        self.colorSlider.addTarget(self, action: "sliderAction:", forControlEvents: UIControlEvents.ValueChanged);
        
        hueValue = CGFloat(Int(colorSlider.value)) / 10;
        var colorTextColor:UIColor = UIColor(hue: hueValue, saturation: initSaturation, brightness: initBrightness, alpha: initAlpha);
        self.colorLabel.textColor = colorTextColor;
        
        self.doneButton = UIButton(frame: frames[4]);
        self.doneButton.setTitle("Done", forState: UIControlState.Normal);
        self.doneButton.addTarget(self, action: "done:", forControlEvents: UIControlEvents.TouchUpInside);
        
        self.addSubview(budgetLabel);
        self.addSubview(budgetField);
        self.addSubview(colorLabel);
        self.addSubview(colorSlider);
        self.addSubview(doneButton);
    }
    
    func textFieldShouldReturn(input: UITextField!) -> Bool {
        input.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        super.touchesBegan(touches as NSSet, withEvent: event);
        budgetField.resignFirstResponder();
    }
    
    @IBAction func done(sender: AnyObject){
        if(budgetField.text == ""){
            delegate.emptyAlert();
        }else{
            var budgetDouble:Double = (budgetField.text as NSString).doubleValue;
            //self.delegate!.addBucketCell(nameField.text, budget: budgetDouble, hue:hueValue);
            self.delegate!.setTotalBudget(budgetDouble, hue:hueValue);
            self.budgetField.text = "";
        }
    }
    
    @IBAction func sliderAction(sender:AnyObject){
        hueValue = CGFloat(Int(colorSlider.value)) / 10;
        var colorTextColor:UIColor = UIColor(hue: hueValue, saturation: initSaturation, brightness: initBrightness, alpha: initAlpha);
        self.colorLabel.textColor = colorTextColor;
    }
    
}
