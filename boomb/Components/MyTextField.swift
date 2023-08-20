//
//  MyTextField.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI

struct MyTextField: View {
    @Binding var text: String
    
    var body: some View {
        let binding = Binding<String>(get: {
            self.text
        }, set: {
            self.text = $0.uppercased().trimmingCharacters(in: .whitespacesAndNewlines)
        })
        
        TextField(text: binding) {
            Text("")
        }
        
        .textCase(.uppercase)
        .padding(16)
        .overlay(
            Rectangle()
                .inset(by: 2)
                .stroke(.black, lineWidth: 4)
        )
        .background(.white)
    }
}

struct MyTextField_Previews: PreviewProvider {
    static var previews: some View {
        MyTextField(text: .constant(""))
    }
}
