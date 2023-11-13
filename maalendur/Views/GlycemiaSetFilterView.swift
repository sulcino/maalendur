//
//  GlycemiaSetFilterView.swift
//  maalendur
//
//  Created by Bilbo Sulcino on 08.11.2023.
//

import SwiftUI

struct GlycemiaSetFilterView: View {
  @Environment(\.dismiss) var dismiss
  @Binding var fromDate: Date
  @Binding var toDate: Date

  var body: some View {
    NavigationStack {
      Form {
        Text("from")
        DatePicker("from date", selection: $fromDate, displayedComponents: [.date])
          .datePickerStyle(.wheel)
          .padding(.horizontal, 40)
        Text("to")
        DatePicker("to date", selection: $toDate, displayedComponents: [.date])
          .datePickerStyle(.wheel)
          .padding(.horizontal, 40)
      }.navigationTitle("set filter")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItemGroup(placement: .topBarLeading) {
            Button("Close") { dismiss() }
          }
        }
        .onDisappear {
          fromDate = TimeFormatService.timeToStartOfDay(fromDate)
          toDate = TimeFormatService.timeToEndOfDay(toDate)
        }
    }
  }
}

//#Preview {
//    GlycemiaSetFilterView()
//}
