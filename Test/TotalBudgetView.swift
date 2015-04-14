//
//  TotalBudgetView.swift
//  Test
//
//  Created by Zehao Zhang on 15/4/8.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

class TotalBudgetView: UIView {
    let xmarginProportion:CGFloat = 0.1;
    let ymarginProportion:CGFloat = 0.1;
    
    var totalLimit:Double = 0;
    var currentSpending:Double = 0;
    
    var textR:CGFloat = 255 / 255.0;
    var textG:CGFloat = 204 / 255.0;
    var textB:CGFloat = 102 / 255.0;
    var defaultAlpha:CGFloat = 1;
    var budgetText:UILabel = UILabel();
    var budgetNum:UILabel = UILabel();
    
    var textFrameX:CGFloat = 0;
    var textFrameY:CGFloat = 0;
    var textFrameW:CGFloat = 0;
    var textFrameH:CGFloat = 0;
    
    override init(frame:CGRect) {
        super.init(frame: frame);
        //self.backgroundColor = UIColor.whiteColor();
        textFrameX = frame.width * xmarginProportion;
        textFrameY = frame.height * ymarginProportion;
        textFrameW = frame.width * (1 - 2 * xmarginProportion);
        textFrameH = frame.height * (1 - 2 * ymarginProportion);
        budgetNum = UILabel(frame: CGRect(x: textFrameX, y: textFrameY, width: textFrameW, height: textFrameH));
        budgetNum.text = String(format:"%.02f / %.02f", currentSpending, totalLimit);
        budgetNum.font = UIFont(name: budgetNum.font.fontName, size: 35)
        budgetNum.textAlignment = NSTextAlignment.Center;
        //sbudgetNum.textColor = UIColor(red: textR, green: textG, blue: textB, alpha: defaultAlpha);
        self.addSubview(budgetNum);
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setTotalBudget(limit:Double){
        self.totalLimit = limit;
        budgetNum.text = String(format:"%.02f / %.02f", currentSpending, totalLimit);
    }
    
    func setColor(color:UIColor){
        self.backgroundColor = color;
        //self.alpha = 0.3;
    }
    
}
