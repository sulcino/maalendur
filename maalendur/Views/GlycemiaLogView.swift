//
//  GlycemiaLogView.swift
//  maalendur
//
//  Created by Bilbo Sulcino on 01.11.2023.
//

import SwiftUI
import SwiftData

struct GlycemiaLogView: View {
  @Environment(\.modelContext) private var modelContext
  @AppStorage("fromDateFilter") private var fromDateFilter: Date = Date(timeIntervalSinceNow: -(7 * 24 * 60 * 60))
  @AppStorage("toDateFilter") private var toDateFilter: Date = Date()
  @State var editedRecord: GlycemiaLogRecord?
  @State var newRecord: GlycemiaLogRecord?

  @State var showFilterView: Bool = false

  @Query(sort: [
    SortDescriptor(\GlycemiaLogRecord.timestamp, order: .forward),
    SortDescriptor(\GlycemiaLogRecord.measurementDaytimeRawValue, order: .forward),
  ]) private var glycemiaRecords: [GlycemiaLogRecord]


  var body: some View {
    ZStack {
      Color("Background")
        .ignoresSafeArea(.all)

      VStack {
        ScrollViewReader { scrollView in
          List {
            ForEach(filterRecords(), id: \.id) { record in
              GlycemiaListElementView(record: record, editedRecord: $newRecord)
            }.onDelete(perform: deleteRecord)
              .listRowBackground(Color("TextBackground"))
              .listRowSeparatorTint(Color("ListSeparatorColor"))
              .alignmentGuide(.listRowSeparatorLeading, computeValue: { _ in 0 })
          }.scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
        }

        // Statistics
        // TODO: move to separate file
        VStack(spacing: 6) {
          VStack {
            Text(String(localized: "Average glycemy"))
              .font(.footnote)
            Text(String(format: "%0.1f", averageGlyc()))
              .fontWeight(.black)
              .font(.title)
          }
          Divider()
          HStack {
            VStack {
              Text(String(localized: "average morning")).font(.footnote)
              Text(String(format: "%0.1f", averageGlyc(daytime: .morning))).fontWeight(.bold)
            }
            Spacer()
            VStack {
              Text(String(localized: "average after lunch")).font(.footnote)
              Text(String(format: "%0.1f", averageGlyc(daytime: .afterLunch))).fontWeight(.bold)
            }
            Spacer()
            VStack {
              Text(String(localized: "average evening")).font(.footnote)
              Text(String(format: "%0.1f", averageGlyc(daytime: .evening))).fontWeight(.bold)
            }
          }
        }.padding(.horizontal, 50)
          .foregroundColor(Color("Text"))
      }
    }.toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          showFilterView.toggle()
        }, label: {
          Label("", systemImage: "line.3.horizontal.decrease.circle")
        })
      }
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          newRecord = GlycemiaLogRecord()
        }, label: {
          Label("", systemImage: "plus")
        })
      }
    }
    .sheet(item: $newRecord) { record in
      EditGlycemiaLogRecord(record: $newRecord, newRecord: true)
    }
    .sheet(item: $editedRecord) { record in
      EditGlycemiaLogRecord(record: $editedRecord, newRecord: false)
    }
    .sheet(isPresented: $showFilterView) {
      GlycemiaSetFilterView(fromDate: $fromDateFilter, toDate: $toDateFilter)
    }
  }

  private func averageGlyc(daytime: MeasurementDaytime? = nil) -> Double {
    let daytimes: [Int] = daytime == nil ? [1, 2, 3] : [daytime!.rawValue]
    let records = filterRecords(daytimes: daytimes)
    let average = records.reduce(0.0) { s, record in s + record.glycemia! } / Double(records.count)
    let roundedAverage = round(average * 10) / 10
    return roundedAverage
  }

  private func deleteRecord(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(glycemiaRecords[index])
      }
    }
  }

  private func filterRecords(daytimes: [Int]? = nil) -> ([GlycemiaLogRecord]) {
    let daytimesFilter: [Int] = daytimes ?? [1, 2, 3]
    let predicate = #Predicate<GlycemiaLogRecord> { record in
      record.timestamp! >= fromDateFilter &&
      record.timestamp! <= toDateFilter &&
      daytimesFilter.contains(record.measurementDaytimeRawValue!)
    }
    return (try? glycemiaRecords.filter(predicate)) ?? []
  }

}


//#Preview {
//    GlycemiaLogView()
//}
