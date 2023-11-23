//
//  Extensions.swift
//  MetUCD
//
//  Created by Miaomiao Shi on 23/11/2023.
//

import Foundation
import SwiftUI

extension Double {
    // Convert decimal degrees to degrees, minutes, seconds format
    func toDMS(isLatitude: Bool = true) -> String {
        let isNegative = self < 0
        var seconds = abs(self * 3600)
        let degrees = Int(seconds / 3600)
        seconds = seconds.truncatingRemainder(dividingBy: 3600)
        let minutes = Int(seconds / 60)
        seconds = seconds.truncatingRemainder(dividingBy: 60)

        let direction: String
        if isLatitude {
            direction = isNegative ? "S" : "N"
        } else {
            direction = isNegative ? "W" : "E"
        }

        return "\(degrees)° \(minutes)' \(Int(seconds))\" \(direction)"
    }
}

extension Double {
    // Convert Unix timestamp to formatted time string in local time, based on given timezone offset
    func toLocalTimeString(timezoneOffset: Double) -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: Int(timezoneOffset))

        return dateFormatter.string(from: date)
    }
}

extension Double {
    // Convert Unix timestamp to formatted time string in London timezone
    func toTimeStringInLondon() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        // Set timezone to London's current timezone (either GMT or BST)
        dateFormatter.timeZone = TimeZone(identifier: "Europe/London")

        return dateFormatter.string(from: date)
    }
}


extension Double {
    func formatTimeZone() -> String {
        let offsetInHours = self / 3600
        return "\(Int(offsetInHours))H"
    }
}
