//
//  Item.swift
//  maalendur
//
//  Created by Bilbo Sulcino on 28.10.2023.
//

import Foundation
import SwiftData

@Model
final class GlycemiaLogRecord {
  var id = UUID()
  var glycemia: Double?
  var timestamp: Date?
  var measurementDaytimeRawValue: Int?

  var timestampAccess: Date {
    get { return timestamp! }
    set { timestamp = TimeFormatService.timeToStartOfDay(newValue) }
  }

  init(glycemia: Double = 0.0, measurementDaytimeRawValue: Int = 1, timestamp: Date = Date()) {
    self.glycemia = glycemia
    self.timestamp = timestamp
    self.measurementDaytimeRawValue = measurementDaytimeRawValue
  }

  // TODO: convert to property with getter/setter
  func measurementDaytime() -> MeasurementDaytime {
    return MeasurementDaytime(rawValue: measurementDaytimeRawValue!)!
  }

}
