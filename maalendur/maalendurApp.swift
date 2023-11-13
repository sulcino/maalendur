//
//  maalendurApp.swift
//  maalendur
//
//  Created by Bilbo Sulcino on 28.10.2023.
//

import SwiftUI
import SwiftData

@main
struct maalendurApp: App {
  var sharedModelContainer: ModelContainer = {
    let schema = Schema([GlycemiaLogRecord.self])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()
  
  var body: some Scene {
    WindowGroup {
      HomeView()
    }
    .modelContainer(sharedModelContainer)
  }
}
