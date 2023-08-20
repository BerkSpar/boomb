//
//  PlayerTile.swift
//  boomb
///Users/felipepassos/Documents/github/boomb/boomb/Components/PlayerTile.swift
//  Created by Felipe Passos on 02/08/23.
//

import SwiftUI

struct PlayerTile: View {
    var name: String
    var subtitle: String?
    var size: Double = 100
    var isHorizontal: Bool = false
    
    @ViewBuilder
    var content: some View {
        Ellipse()
          .foregroundColor(.clear)
          .frame(width: size, height: size)
          .background(
              AsyncImage(
                url: URL(string: "https://api.dicebear.com/6.x/bottts-neutral/png?seed=\(name)"),
                content: { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(maxWidth: size, maxHeight: size)
                },
                placeholder: {
                    ProgressView()
                }
              )
              .frame(maxWidth: size, maxHeight: size)
              .cornerRadius(100)
              
          )
          .overlay(
              Ellipse()
                  .inset(by: 2)
                  .stroke(.black, lineWidth: 2)
          )
          
        Text("\(name.uppercased())\(isHorizontal ? ":" : "")")
              .font(Font.custom("Dimitri", size: 16))
              .foregroundColor(.black)
          
          if (subtitle != nil) {
              Text(subtitle!.uppercased())
                  .font(Font.custom("Dimitri", size: 16))
                  .foregroundColor(.black)
          }
    }
    
    var body: some View {
        if (isHorizontal) {
            HStack(spacing: 8) {
                content
            }
        } else {
            VStack(spacing: 8) {
                content
            }
            .frame(width: 100)
        }
        
    }
}

struct PlayerTile_Previews: PreviewProvider {
    static var previews: some View {
        PlayerTile(
            name: "BEA",
            subtitle: "1000 pts"
        )
        
        PlayerTile(
            name: "BEA",
            subtitle: "1000 pts",
            size: 50,
            isHorizontal: true
        )
    }
}
