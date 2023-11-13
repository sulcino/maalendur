//
//  ButtonHome.swift
//  maalendur
//
//  Created by Bilbo Sulcino on 29.10.2023.
//

import Foundation
import SwiftUI

struct ButtonLabelBasicStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    Label(configuration)
      .frame(maxWidth: .infinity)
      .padding(.vertical, 18)
      .padding(.horizontal, 28)
      .background(Color("ButtonBackground"))
      .foregroundColor(Color("ButtonText"))
      .cornerRadius(6)
  }
}
