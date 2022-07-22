//
//  CustomDateFormatter.swift
//  SmartUseApp
//
//  Created by Владимир Ли on 22.07.2022.
//

import Foundation

class CustomDateFormatter: DateFormatter {
    
    func convertToString(date: Date) -> String {
        setupFormatter()
        
//        timeZone = .current
//        locale = .current
//        timeStyle = .none
//        dateStyle = .short
        dateFormat = "yyyy/MM/dd"
        
        let string = self.string(from: date)
        return string
    }
    
    func convertToDate(string: String) -> Date {
        setupFormatter()
//
//        timeZone = .current
//        locale = .current
//        timeStyle = .none
////        dateStyle = .short
        dateFormat = "yyyy/MM/dd"
        
        guard let date = self.date(from: string) else {
            print("ffdffd")
            return Date()
        }
        return date
    }
    
    private func setupFormatter() {
        timeZone = .current
        locale = .current
        timeStyle = .none
//        dateStyle = .short
        dateFormat = "yyyy/MM/dd"
    }
}
