//
//  SettingsModel.swift
//  Test
//
//  Created by Anthony Davanzo on 3/30/15.
//  Copyright (c) 2015 Zehao Zhang. All rights reserved.
//
//    Settings:
//    - Currency?
//    - OverBudget
//    - Export Data?
//    - Select time interval: 7 days for now?
//    - total budget

import Foundation


class SettingsModel {
    var OverBudget: BooleanLiteralType;
    var totalBudget: Double;
    var interval: String;
    var intervalNum: Int;
    var Currency = "Dollar";
    
    init(totalBudgt: Double){
        interval = "Week";
        intervalNum = 7;
        totalBudget = totalBudgt;
        OverBudget = false;
    }
    
    func setBudget(budget:Double){
        totalBudget = budget;
    }
    
    func allowOverBudget(allow:BooleanLiteralType){
        OverBudget = allow;
    }
    
    func chooseCurrency(){
        //to be implemented
    }
    
    func exportData (){
        //to be implemented
    }
    
    func SetTimeInterval (){
        //To be implemented
    }
}