//
//  OvalTextFieldStyle.swift
//  LegoFit
//
//  Created by Denis Denisov on 31/7/24.
//

import Foundation
import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .frame(alignment: .trailing)
            .tint(.white)
            .background(clearGray)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .keyboardType(.numberPad)
    }
}
