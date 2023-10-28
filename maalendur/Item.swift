//
//  Item.swift
//  maalendur
//
//  Created by Bilbo Sulcino on 28.10.2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
