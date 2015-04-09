//
//  TotalBudgetView.swift
//  Test
//
//  Created by Zehao Zhang on 15/4/8.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import UIKit

class TotalBudgetView: UIView {
    
    var textR:CGFloat = 255 / 255.0;
    var textG:CGFloat = 204 / 255.0;
    var textB:CGFloat = 102 / 255.0;
    var budgetText:UILabel = UILabel();
    var budgetNum:UILabel = UILabel();
    
    var textFrameX:CGFloat = 0;
    var textFrameY:CGFloat = 0;
    var textFrameW:CGFloat = 0;
    var textFrameH:CGFloat = 0;
    
    override init(frame:CGRect) {
        super.init(frame: frame);
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
