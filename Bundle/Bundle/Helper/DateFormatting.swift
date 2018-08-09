//
//  DateFormatting.swift
//  Bundle
//
//  Created by Pei Qin on 2018/8/1.
//  Copyright © 2018 Pei Qin. All rights reserved.
//

import Foundation
struct FormattedDate {
    static let currentDate = Date()
    static let dateFormatter = DateFormatter()
    
}

extension Date {
    func convertToString() -> String {
        let withYear = DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: DateFormatter.Style.none)
        let array = withYear.components(separatedBy: ",")
        return array[0]
    }
    
    func convertToStringToday() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
    }
    
    func convertToStringIncludeYear() -> String {
        return DateFormatter.localizedString(from: self, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
    }
    
    func isInSameWeek(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }
    func isInSameMonth(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }
    func isInSameYear(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .year)
    }
    func isInSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .day)
    }
    var isInThisWeek: Bool {
        return isInSameWeek(date: Date())
    }
    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    var isInThisMonth: Bool {
        return isInSameMonth(date: Date())
    }
    var isInThisYear: Bool {
        return isInSameYear(date: Date())
    }
    var isInTheFuture: Bool {
        return Date() < self
    }
    var isInThePast: Bool {
        return self < Date()
    }
}
