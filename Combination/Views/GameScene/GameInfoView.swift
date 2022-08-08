//
//  GameInfoView.swift
//  Combination
//
//  Created by 이정원 on 2022/07/22.
//

import SwiftUI

struct GameInfoView: View {
    let round: String
    let elapsedTime: String
    let score: String
    let userAnswer: [String]
    let isGamePaused: Bool
    
    var body: some View {
        VStack {
            Text(round)
                .font(.system(size: 25))
                .fontWeight(.medium)
                .padding(.top)
            Divider()
            HStack {
                VStack(spacing: 10) {
                    Text("시간")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    Text(elapsedTime)
                        .font(.notoSans(size: 20))
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                Divider()
                VStack(spacing: 10) {
                    Text("점수")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    Text(score)
                        .font(.notoSans(size: 20))
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
            }
            .fixedSize(horizontal: false, vertical: true)
            Divider()
            if !isGamePaused {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 5) {
                    ForEach(userAnswer, id: \.self) { answer in
                        Text(answer)
                            .font(.notoSans(size: 20))
                            .fontWeight(.bold)
                    }
                }
                Divider()
            }
        }
    }
}
