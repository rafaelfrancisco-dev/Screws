import Foundation

extension Date {
    //MARK: Static
    
    /// Create a date from a day and a month.
    /// - Parameters:
    ///     - day: Specific day.
    ///     - month: Specifc month.
    ///  - Returns:
    ///     The date with the specifc day and month.
    public static func dateFromDayAndMonth(day: Int, month: Int) -> Date? {
        var components = DateComponents()
        
        components.hour = 0
        components.minute = 0
        components.year = 2000
        components.day = day
        components.month = month
        
        return Calendar.current.date(from: components)
    }
    
    //MARK: Instance
    
    /// - Returns:
    /// The day in the year of the date.
    public func getDayInYear() -> Int {
        let cal = Calendar.current
        return cal.ordinality(of: .day, in: .year, for: self)!
    }
    
    /// - Returns:
    /// The specific component from the date.
    public func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    /// - Returns:
    /// The specific component from the date.
    public func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    /// - Returns:
    /// All months in the year.
    public static func months() -> [String]? {
        let formatter = DateFormatter()
        let monthComponents = formatter.monthSymbols
        
        return monthComponents
    }
}
