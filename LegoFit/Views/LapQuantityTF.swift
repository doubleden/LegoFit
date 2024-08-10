//
//  LapQuantityTF.swift
//  LegoFit
//
//  Created by Denis Denisov on 31/7/24.
//

import SwiftUI

struct LapQuantityTF: View {
    @Binding var input: String
    @FocusState.Binding var isFocused: Bool
    
    let plusAction: () -> Void
    let minusAction: () -> Void
    
    var body: some View {
        VStack(spacing: 35) {
            
            TextField("0", text: $input)
                .textFieldStyle(OvalTextFieldStyle())
                .frame(maxWidth: 100)
                .focused($isFocused)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 25) {
                Button(action: {
                    isFocused = false
                    minusAction()
                }, label: {
                    Image(systemName: "minus.circle")
                        .font(.title)
                })
                
                Button(action: {
                    isFocused = false
                    plusAction()
                }, label: {
                    Image(systemName: "plus.circle")
                        .font(.title)
                })
            }
            .tint(.white)
        }
    }
}

#Preview {
    @FocusState var isFocused
    return LapQuantityTF(input: .constant("2"), isFocused: $isFocused, plusAction: {}, minusAction: {})
        .padding()
}
