//
//  ButtonLabelDisabledStyle.swift
//  maalendur
//
//  Created by Bilbo Sulcino on 12.11.2023.
//

import Foundation
import SwiftUI

struct ButtonLabelDisabledStyle: LabelStyle {
  func makeBody(configuration: Configuration) -> some View {
    Label(configuration)
      .frame(maxWidth: .infinity)
      .padding(.vertical, 8)
      .padding(.horizontal, 28)
      .background(Color("ButtonBackgroundDisabled"))
      .foregroundColor(Color("ButtonTextDisabled"))
      .cornerRadius(6)
  }
}
