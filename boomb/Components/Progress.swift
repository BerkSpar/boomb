//
//  Progress.swift
//  boomb
//
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI

struct Progress: View {
    @Binding var progress: Double
    
    func getColor() -> Color {
        progress <= 0.3 ? .red : Color.myGreen
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                  .foregroundColor(getColor().opacity(0.5))
                  .frame(maxWidth: geo.size.width)
                
                Rectangle()
                  .foregroundColor(getColor())
                  .frame(maxWidth: geo.size.width * progress)
            }
        }
        .frame(height: 16)
        .animation(.linear, value: progress)
    }
}

struct Progress_Previews: PreviewProvider {
    static var previews: some View {
        Progress(progress: .constant(0.2))
    }
}
