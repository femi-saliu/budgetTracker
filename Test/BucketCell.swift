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
    var bgColorHue:CGFloat = 0;
    var limit:Double = 0;
    var nameLabel:UILabel = UILabel();
    var limitLabel:UILabel = UILabel();
    var color:UIColor = UIColor();
    let defaultTextColor = UIColor.blackColor();
    let saturationLowerLimit:CGFloat = 20 / 100;
    let saturationUpperLimit:CGFloat = 100 / 100;
    var currentSaturation:CGFloat = 0;
    let defaultBrightness:CGFloat = 100 / 100;
    let defaultAlpha:CGFloat = 1;

    
    //todo: add color
    init(title: String, limit:Double, frame:CGRect, hue:CGFloat) {
        println("creating bucket");
        let titlex:CGFloat = 0;
        let limitx:CGFloat = frame.width / 2;
        let labely:CGFloat = 0;
        let labelw = frame.width / 2;
        let labelh = frame.height;
        self.title = title;
        self.limit = limit;
        self.bgColorHue = hue;
        self.currentSaturation = saturationLowerLimit;
        nameLabel = UILabel(frame:CGRect(x: titlex, y: labely, width: labelw, height: labelh));
        limitLabel = UILabel(frame:CGRect(x: limitx, y: labely, width: labelw, height: labelh));
        
        super.init(frame: frame);
        
        self.color = UIColor(hue: bgColorHue, saturation: currentSaturation, brightness: defaultBrightness, alpha: defaultAlpha);
        self.backgroundColor = color;
        self.addSubview(nameLabel);
        self.addSubview(limitLabel);
        
        nameLabel.text = title;
        nameLabel.font = UIFont(name: "Helvetica",
            size: 16.0)
        nameLabel.textAlignment = NSTextAlignment.Center;
        nameLabel.textColor = defaultTextColor;
        nameLabel.alpha = 1;
        limitLabel.text = String(format:"%.02f / %.02f", currentSpending, limit);
        limitLabel.font = UIFont(name: "Helvetica",
            size: 16.0)
        limitLabel.textAlignment = NSTextAlignment.Center;
        limitLabel.textColor = defaultTextColor;
        limitLabel.alpha = 1;
        
        //swipeCell.addTarget(self, action: "deleteBucket");
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getName()->String {
        return title;
    }
    
    func setSpending(spend:Double, saturation:CGFloat){
        currentSpending = spend;
        self.backgroundColor = UIColor(hue: bgColorHue, saturation: saturation, brightness: defaultBrightness, alpha: defaultAlpha);
    }
    
    //var delegate: bucketCellProtocol?
//    func deleteBucket() {
//        delegate?.deleteBucketCell(title);
//    }
    
    
    
}
