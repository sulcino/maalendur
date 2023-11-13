//
//  TimeFormatService.swift
//  maalendur
//
//  Created by Bilbo Sulcino on 08.11.2023.
//

import Foundation

class TimeFormatService {
  static let calendar = Calendar.current
  static let dateFormatter = DateFormatter()

  static func timeToStartOfDay(_ timestamp: Date) -> Date {
    return calendar.startOfDay(for: timestamp)
  }

  static func timeToEndOfDay(_ timestamp: Date) -> Date {
    let startOfDay = calendar.startOfDay(for: timestamp)
    return calendar.date(byAdding: .second, value: 24 * 60 * 60 - 1, to: startOfDay)!
  }

  static func dateToString(_ date: Date) -> String {
    dateFormatter.dateFormat = "dd.MM."
    return dateFormatter.string(from: date)
  }

}
