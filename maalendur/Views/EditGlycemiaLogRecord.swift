//
//  EditGlycemiaLogRecord.swift
//  maalendur
//
//  Created by Bilbo Sulcino on 04.11.2023.
//

import SwiftUI

struct EditGlycemiaLogRecord: View {
  @Environment(\.modelContext) private var modelContext
  @Environment(\.dismiss) var dismiss

  @Binding var record: GlycemiaLogRecord!
  let newRecord: Bool

  @State var daytime: Int = 1
  @State var glycemia: Double? = nil
  @State var timestamp: Date = Date()


  var body: some View {
    //    VStack(spacing: 30) {
    NavigationStack {
      Form {
        TextField("Enter glycemy", value: $glycemia, format: .number)
          .padding(.horizontal, 40)
          .keyboardType(.decimalPad)
          .font(.title)
          .fontWeight(.bold)
          .multilineTextAlignment(.center)

        Picker("Daytime", selection: $daytime) {
          ForEach(MeasurementDaytime.allCases) { daytime in
            Text(daytime.localizedNameForGlycemia())
              .tag(daytime)
          }
        }.pickerStyle(.segmented)
          .padding(.horizontal, 40)

        DatePicker("date", selection: $timestamp, displayedComponents: [.date])
          .datePickerStyle(.automatic)
          .padding(.horizontal, 80)
        //        .labelsHidden()

      }.onAppear {
        self.daytime = record.measurementDaytimeRawValue!
        self.glycemia = record.glycemia! == 0 ? nil : record.glycemia
        self.timestamp = record.timestamp!
      }.navigationTitle("Edit record")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItemGroup(placement: .topBarLeading) {
            Button("Cancel") { dismiss() }
          }
          ToolbarItemGroup(placement: .topBarTrailing) {
            Button("Save") {
              record.measurementDaytimeRawValue = daytime
              record.glycemia = glycemia ?? 0.0
              record.timestampAccess = timestamp
              if newRecord {
                modelContext.insert(record)
              }
              dismiss()
            }
          }
        }
    }
  }
}

#if DEBUG
struct EditGlycemiaLogRecord_Preview: PreviewProvider {
  @State static var record: GlycemiaLogRecord? = GlycemiaLogRecord(
    glycemia: 5.2,
    measurementDaytimeRawValue: 3,
    timestamp: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 1))!
  )

  static var previews: some View {
    EditGlycemiaLogRecord(record: $record, newRecord: true)
  }
}
#endif


//#Preview {
//  EditGlycemiaLogRecord(
//    editedRecord: GlycemiaLogRecord(
//      glycemia: 5.2,
//      measurementDaytimeRawValue: 3,
//      timestamp: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 1))!),
//    newRecord: true)
//}
