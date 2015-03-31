//
//  BucketCell.swift
//  Test
//
//  Created by Zehao Zhang on 15/3/24.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

protocol bucketCellProtocol{
    func deleteBucketCell(name:String);
}

class BucketCell: UIButton {
    var title:String = "";
    var color:UIColor = UIColor.whiteColor();
    var limit:Double?
    var nameLabel:UILabel?
    var limitLabel:UILabel?
    let defaultTextColor = UIColor.blackColor();

    
    //todo: add color
    init(title: String, limit:Double, frame:CGRect) {
        println("creating bucket");
        let titlex:CGFloat = 0;
        let labely:CGFloat = 0;
        let labelw = frame.width/2;
        let labelh = frame.height;
        let limitx = titlex + labelw;
        self.title = title;
        self.limit = limit;
        nameLabel = UILabel(frame:CGRect(x: titlex, y: labely, width: labelw, height: labelh));
        limitLabel = UILabel(frame:CGRect(x: limitx, y: labely, width: labelw, height: labelh));
        
        super.init(frame: frame);
        
        self.alpha = 0.3;
        self.backgroundColor = color;
        self.addSubview(nameLabel!);
        self.addSubview(limitLabel!);
        
        nameLabel?.text = title;
        nameLabel?.font = UIFont(name: "Helvetica",
            size: 16.0)
        nameLabel?.textAlignment = NSTextAlignment.Center;
        nameLabel?.textColor = defaultTextColor;
        nameLabel?.alpha = 1;
        limitLabel?.text = String(format:"%.02f", limit);
        limitLabel?.font = UIFont(name: "Helvetica",
            size: 16.0)
        limitLabel?.textAlignment = NSTextAlignment.Center;
        limitLabel?.textColor = defaultTextColor;
        limitLabel?.alpha = 1;

        
        //swipeCell.addTarget(self, action: "deleteBucket");
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getName()->String {
        return title;
    }
    
    var delegate: bucketCellProtocol?
//    func deleteBucket() {
//        delegate?.deleteBucketCell(title);
//    }
    
    
    
}
