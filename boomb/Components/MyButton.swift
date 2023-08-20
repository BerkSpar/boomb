//
//  MyButton.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI

struct MyButton: View {
    var label: String
    var onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Text(label)
//                .font(Font.custom("SF Mono", size: 16))
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding(16)
                .frame(
                    maxWidth: .infinity,
                    alignment: .center
                )
                .background(Color.myBlue)
        }
        .buttonStyle(.plain)
    }
}

struct MyButton_Previews: PreviewProvider {
    static var previews: some View {
        MyButton(label: "ENTER") { }
    }
}
