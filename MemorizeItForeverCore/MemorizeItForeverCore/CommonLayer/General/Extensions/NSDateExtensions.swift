//
//  NSDateExtensions.swift
//  MemorizeItForever
//
//  Created by Hadi Zamani on 5/1/16.
//  Copyright © 2016 SomeSimpleSolution. All rights reserved.
//

import Foundation

extension Date{
    
    func getDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: dateFormatter.string(from: self))
    }
    
    func addDay(_ days: Int) -> Date? {
//        let components = DateComponents()
//        (components as NSDateComponents).setValue(days, forComponent: NSCalendar.Unit.day);
//        return (Calendar.current as NSCalendar).date(byAdding: components, to: self, options: NSCalendar.Options(rawValue: 0))
        
        return self.addingTimeInterval(Double(days) * 24 * 60 * 60)
    }
    
    func equalToDateWithoutTime(_ dateToCompare: Date) -> Bool {
       if (Calendar.current as NSCalendar).compare(self, to: dateToCompare, toUnitGranularity: .day) == ComparisonResult.orderedSame {
            return true
        }
        return false
    }
}
