//
//  ListElementView.swift
//  maalendur
//
//  Created by Bilbo Sulcino on 13.11.2023.
//

import SwiftUI

struct GlycemiaListElementView: View {
  let record: GlycemiaLogRecord

  @Binding var editedRecord: GlycemiaLogRecord?

  var body: some View {
    HStack {
      HStack {
        HStack {
          Text(String(format: "%.1f", record.glycemia!))
            .fontWeight(.bold)
            .foregroundStyle(Color("Text"))
            .frame(minWidth: 45, alignment: .trailing)
          Spacer()
        }
        HStack {
          Text(record.measurementDaytime().localizedNameForGlycemia())
            .foregroundStyle(Color("Text"))
          Spacer()
          Text(TimeFormatService.dateToString(record.timestamp!))
            .font(.footnote)
            .foregroundStyle(Color("Text"))
            .frame(minWidth: 40, alignment: .trailing)
        }
      }
    }
    .onTapGesture {
      editedRecord = record
    }
  }
}


//#Preview {
//    ListElementView()
//}
