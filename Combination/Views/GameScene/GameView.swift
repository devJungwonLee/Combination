//
//  GameView.swift
//  Combination
//
//  Created by 이정원 on 2022/06/11.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @Binding var isActive: Bool
    
    private let layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            NavigationLink(isActive: $viewModel.shouldPush) {
                GameResultView(
                    viewModel: GameResultViewModel(record: viewModel.record),
                    isGameViewActive: $isActive,
                    shouldPush: $viewModel.shouldPush
                )
            } label: { EmptyView() }
            
            GameInfoView(
                round: viewModel.round,
                elapsedTime: viewModel.elapsedTime,
                score: viewModel.score,
                userAnswer: viewModel.userAnswer,
                isGamePaused: viewModel.isGamePaused
            )
            
            if !viewModel.isGamePaused {
                LazyVGrid(columns: layout, spacing: 15) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .padding(.horizontal, 25)
                            .onTapGesture {
                                viewModel.cardDidTap(card)
                            }
                    }
                }
                .padding(.all)

                Spacer()
                
                HStack {
                    Button {
                        viewModel.hintButtonDidTap()
                    } label: {
                        Text("힌트")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom)
                    .padding(.leading)
                    .buttonStyle(.bordered)
                    Button {
                        viewModel.finishButtonDidTap()
                    } label: {
                        Text("결")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom)
                    .padding(.trailing)
                    .buttonStyle(.bordered)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("게임종료") {
                    viewModel.exitButtonDidTap()
                }
                .alert(isPresented: $viewModel.shouldShowAlert) {
                    Alert(
                        title: Text("게임 종료"),
                        message: Text("지금 게임을 종료하면\n기록은 저장되지 않습니다."),
                        primaryButton: .destructive(Text("종료")) {
                            viewModel.alertExitButtonDidTap()
                            isActive = false
                        },
                        secondaryButton: .cancel(Text("취소"))
                    )
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(viewModel.playOrPauseButtonTitle) {
                    viewModel.playOrPauseButtonDidTap()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.viewDidAppear()
        }
        .toast(isShowing: $viewModel.shouldShowMessage, message: viewModel.message)
        .toast(isShowing: $viewModel.shouldShowHint, cards: viewModel.hint)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            viewModel.willResignActive()
        }
    }
}
