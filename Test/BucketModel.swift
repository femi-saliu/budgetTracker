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
    
    var transactions = [Double]();
    var balances = [Double]();
    var descriptions = [String]();
    var transactionTypes = [Int]();
    
    init(n:String,newlimit:Double, hue:CGFloat) {
        limit = newlimit;
        name = n;
        currentHue = hue;
        spending = 0;
        currentSaturation = saturationLowerLimit;
    }
    func removeTransaction(desc:String){
        var index = 0;
        var found = true;
        for description in descriptions{
            if(desc == description){
                descriptions.removeAtIndex(index);
                found = true;
                break;
            }
            index++ ;
        }
        if(found){
            self.spending -= transactions[index];
            transactions.removeAtIndex(index);
            currentSaturation = saturationLowerLimit + CGFloat(spending / limit) * (saturationUpperLimit - saturationLowerLimit);
        }
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
    
    func availableBudget()->Double{
        return limit - spending;
    }
    
    func getTransactions()->[Double]{
        return transactions;
    }
    func getDescriptions()->[String]{
        return descriptions;
    }
    func getTransactionTypes()->[Int]{
        return transactionTypes;
    }
    func addtoBalance(s:Double, desc:String) -> Bool{
        if(spending + s <= limit){
            spending += s;
            currentSaturation = saturationLowerLimit + CGFloat(spending / limit) * (saturationUpperLimit - saturationLowerLimit);
            transactions.append(s);
            descriptions.append(desc);
            transactionTypes.append(0);
            return true;
        }else{
            return false;
        }
        
    }

    func addTransfer(amt:Double, desc:String, sign:Int){
        if(sign == 1){
            limit += amt;
        }else{
            limit -= amt;
        }
        currentSaturation = saturationLowerLimit + CGFloat(spending / limit) * (saturationUpperLimit - saturationLowerLimit);
        transactions.append(amt);
        descriptions.append(desc);
        transactionTypes.append(1);
    }
    func subtractFromBalance(s:Double){
        spending -= s;
        currentSaturation = saturationLowerLimit + CGFloat(spending / limit) * (saturationUpperLimit - saturationLowerLimit);
    }
    func getColor() -> UIColor{
        let currentColor = UIColor(hue: currentHue, saturation: currentSaturation, brightness: defaultBrightness, alpha: defaultAlpha);
        return currentColor;
    }
}