//
//  DateManager.swift
//  LetsGoTravel
//
//  Created by Natali Malich
//

import Foundation

class DateManager {
    
    // MARK: - Properties
    static let shared = DateManager()
    
    // MARK: - Funcs
    func getDateFromString(dateString: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        guard let dateString = formatter.date(from: dateString) else {
            return nil
        }
        return dateString
    }
    
    func getStringFromDate(date: Date, dateFormat: String?) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
}
