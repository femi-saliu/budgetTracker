//
//  BucketModel.swift
//  Test
//
//  Created by Zehao Zhang on 15/3/11.
//  Copyright (c) 2015年 Zehao Zhang. All rights reserved.
//

import Foundation

class BucketModel {
    var limit = 0.0;
    var name:String;
    var spending:Double;
    init(n:String,newlimit: Double){
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