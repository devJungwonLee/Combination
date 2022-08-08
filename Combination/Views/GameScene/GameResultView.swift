//
//  GameResultView.swift
//  Combination
//
//  Created by 이정원 on 2022/07/30.
//

import SwiftUI

struct GameResultView: View {
    @ObservedObject var viewModel: GameResultViewModel
    @Binding var isGameViewActive: Bool
    @Binding var shouldPush: Bool
    
    var body: some View {
        VStack(spacing: 50) {
            Spacer()
            Text("수고하셨습니다")
                .font(.system(size: 30))
                .fontWeight(.semibold)
            HStack {
                VStack(spacing: 10) {
                    Text("시간")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    Text(viewModel.elapsedTime)
                        .font(.notoSans(size: 20))
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                Divider()
                VStack(spacing: 10) {
                    Text("점수")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                    Text(viewModel.score)
                        .font(.notoSans(size: 20))
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
            }
            .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            Button {
                shouldPush = false
                isGameViewActive = false
            } label: {
                Text("홈 화면으로 돌아가기")
                    .font(.system(size: 25))
                    .fontWeight(.semibold)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
            }
            .padding(.bottom)
            .padding(.horizontal)
            .buttonStyle(.bordered)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.viewDidAppear()
        }
    }
}

struct GameResultView_Previews: PreviewProvider {
    @State static var isGameViewActive = true
    @State static var shouldPush = true
    static var previews: some View {
        GameResultView(
            viewModel: GameResultViewModel(
                record: Record(
                    date: Date(),
                    elapsedSeconds: 324,
                    score: 29,
                    numberOfAnswer: 49,
                    trialCount: 90,
                    hintCount: 40
                )
            ),
            isGameViewActive: $isGameViewActive,
            shouldPush: $shouldPush
        )
    }
}
