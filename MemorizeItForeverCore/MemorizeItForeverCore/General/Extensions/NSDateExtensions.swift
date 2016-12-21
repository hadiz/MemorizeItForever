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
        return self.addingTimeInterval(Double(days) * 24 * 60 * 60)
    }
    
    func equalToDateWithoutTime(_ dateToCompare: Date) -> Bool {
       if (Calendar.current as NSCalendar).compare(self, to: dateToCompare, toUnitGranularity: .day) == ComparisonResult.orderedSame {
            return true
        }
        return false
    }
}
