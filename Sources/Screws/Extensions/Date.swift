//
//  File.swift
//  
//
//  Created by Rafael Francisco on 10/01/2024.
//

import Foundation

extension Date {
    func getDayInYear() -> Int {
        let cal = Calendar.current
        return cal.ordinality(of: .day, in: .year, for: self)!
    }
    
    static func dateFromDayAndMonth(day: Int, month: Int) -> Date? {
        var components = DateComponents()
        
        components.hour = 0
        components.minute = 0
        components.year = 2000
        components.day = day
        components.month = month
        
        return Calendar.current.date(from: components)
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
