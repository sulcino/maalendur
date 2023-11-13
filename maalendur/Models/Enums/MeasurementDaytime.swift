//
//  File.swift
//  maalendur
//
//  Created by Bilbo Sulcino on 29.10.2023.
//

import Foundation

enum MeasurementDaytime: Int, Codable, Identifiable, CaseIterable {
  var id: Int { self.rawValue }
  
  case morning = 1
  case afterLunch = 2
  case evening = 3

  func localizedNameForGlycemia() -> String {
    let stringToLocalize = "measurement daytime \(self.rawValue)"
    return String(localized: String.LocalizationValue(stringToLocalize))
  }
}
