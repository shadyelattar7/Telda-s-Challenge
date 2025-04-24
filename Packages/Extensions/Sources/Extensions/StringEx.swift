//
//  StringEx.swift
//
//
//  Created by Al-attar on 23/04/2025.
//

import Foundation

public extension String {
    func extractYear() -> String? {
        // Create a DateFormatter instance
        let dateFormatter = DateFormatter()
        
        // Set the date format to match the given string format
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Convert the string to a Date object
        if let date = dateFormatter.date(from: self) {
            // Create another DateFormatter to extract the year
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            
            // Format the date to get the year
            return yearFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
