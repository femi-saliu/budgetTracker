//
//  BucketModel.swift
//  Test
//
//  Created by Zehao Zhang on 15/3/11.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import Foundation
import UIKit

class BucketModel {
    var limit = 0.0;
    var name:String;
    var spending:Double;
    var currentHue:CGFloat = 0;
    let saturationLowerLimit:CGFloat = 20 / 100;
    let saturationUpperLimit:CGFloat = 100 / 100;
    var currentSaturation:CGFloat = 0;
    let defaultBrightness:CGFloat = 100 / 100;
    let defaultAlpha:CGFloat = 1;
    
    init(n:String,newlimit:Double, hue:CGFloat) {
        limit = newlimit;
        name = n;
        spending = 0;
    }
    func setLimit(nLimit:Double){
        limit = nLimit;
    }
    func getName()->String{
        return name;
    }
    func setname(newName:String){
        name = newName;
    }
    func getLimit()->Double{
        return limit;
    }
    func currentBalance()->Double{
        return spending;
    }
    func addtoBalance(s:Double){
        spending += s;
    }
    func subtractFromBalance(s:Double){
        spending -= s;
    }
    func chooseColor(){
        //to be implemented
    }
}