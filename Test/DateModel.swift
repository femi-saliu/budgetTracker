//
//  DateModel.swift
//  Test
//
//  Created by Anthony Davanzo on 4/22/15.
//  Copyright (c) 2015 Zehao Zhang. All rights reserved.
//

import Foundation


class DateModel {
    
    var StartMonth:Int = 0
    var StartYear:Int = 0
    var CurrentMonth = 0
    var CurrentYear = 0
    
    func CalculateCurrentDate () {
        let calendar = NSCalendar.currentCalendar()
        let StartDate = NSDate()
        let components = calendar.components(.MonthCalendarUnit | .DayCalendarUnit | .YearCalendarUnit, fromDate: StartDate)
        
        
        if StartMonth == 0{
            StartMonth = components.month
        }
        
        if StartYear == 0{
            StartYear = components.year
        }
        
        CurrentMonth = components.month
        CurrentYear = components.year
        
    }
    
    func NewCycle() -> Bool{
        if StartMonth != CurrentMonth{
            return true
        }
        if StartMonth == CurrentMonth{
            if StartYear != CurrentYear{
                return true
            }
        }
        return false
    }
    
    
    
}