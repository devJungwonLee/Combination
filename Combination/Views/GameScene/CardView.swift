//
//  CardView.swift
//  Combination
//
//  Created by 이정원 on 2022/06/11.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var backGroundColor: UIColor {
        switch card.backgroundColor {
        case .white: return .white
        case .gray: return .lightGray
        case .black: return .black
        }
    }
    
    var shapeColor: SwiftUI.Color {
        switch card.shapeColor {
        case .blue: return .blue
        case .red: return .red
        case .yellow: return .yellow
        }
    }
    
    var body: some View {
        ZStack {
            Color(backGroundColor)
                .border(.gray)
            if card.shape == .circle {
                GeometryReader { geometry in
                    Circle()
                        .fill(shapeColor)
                        .padding(geometry.size.width * 0.15)
                }
                
            } else if card.shape == .triangle {
                GeometryReader { geometry in
                    Triangle()
                        .fill(shapeColor)
                        .padding(geometry.size.width * 0.18)
                }
                
            } else if card.shape == .square {
                GeometryReader { geometry in
                    Rectangle()
                        .fill(shapeColor)
                        .padding(geometry.size.width * 0.18)
                }
                
            }
            
            if card.isSelected {
                Color(.white)
                    .opacity(0.5)
                    .border(.selection, width: 3)
                GeometryReader { geometry in
                    Text("\(card.id + 1)")
                        .font(.notoSans(size: geometry.size.width * 0.4))
                        .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(
            id: 0,
            shape: .triangle,
            shapeColor: .yellow,
            backgroundColor: .gray,
            isSelected: true
        ))
    }
}
