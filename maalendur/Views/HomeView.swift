//
//  ContentView.swift
//  maalendur
//
//  Created by Bilbo Sulcino on 28.10.2023.
//

import SwiftUI
import SwiftData

struct HomeView: View {
  @Environment(\.modelContext) private var modelContext
  

  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
        VStack(spacing: 14) {
	          NavigationLink {
            GlycemiaLogView()
          } label: {
            Label(
              String(
                localized: "Glycemia Log"), systemImage: "list.bullet.clipboard"
            ).frame(maxWidth: .infinity)
              .labelStyle(ButtonLabelBasicStyle())
          }

          NavigationLink {
//            MedicationView()
          } label: {
            Label(String(localized: "Medicines"), systemImage: "list.bullet.rectangle")
              .labelStyle(ButtonLabelDisabledStyle())
          }.disabled(true)

          Divider()

          NavigationLink {
          } label: {
            Label(String(localized: "info"), systemImage: "info.circle")
              .labelStyle(ButtonLabelDisabledStyle())
          }.disabled(true)

        }

        Spacer()
        Divider()

        Label(String(localized: "author"), systemImage: "")
      }.frame(maxWidth: .infinity)
        .navigationTitle("Málendur")
        .padding(.horizontal, 30)
        .background(Color("Background"))

    }.background(Color("Background"))

  }

}

#Preview {
  HomeView()
//    .modelContainer(for: GlycemiaLog.self, inMemory: true)
}
