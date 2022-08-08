//
//  Toast.swift
//  Combination
//
//  Created by 이정원 on 2022/07/28.
//

import SwiftUI

struct FeedbackToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    let duration: TimeInterval
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    Spacer()
                    Group {
                        Text(message)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.4))
                    .cornerRadius(12)
                }
                .padding(.bottom, 90)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        isShowing = false
                    }
                }
                .onTapGesture {
                    isShowing = false
                }
            }
        }
    }
}

struct HintToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let cards: [Card]
    let duration: TimeInterval
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                VStack {
                    Spacer()
                    if cards.isEmpty {
                        Group {
                            Text("많이 찾으셨네요!")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(.black.opacity(0.4))
                        .cornerRadius(12)
                    } else {
                        HStack {
                            CardView(card: cards[0])
                            CardView(card: cards[1])
                        }
                        .frame(height: 50)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(.black.opacity(0.4))
                        .cornerRadius(12)
                    }
                }
                .padding(.bottom, 90)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        isShowing = false
                    }
                }
                .onTapGesture {
                    isShowing = false
                }
            }
        }
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, message: String, duration: TimeInterval = 1) -> some View {
        modifier(FeedbackToastModifier(isShowing: isShowing, message: message, duration: duration))
    }
    
    func toast(isShowing: Binding<Bool>, cards: [Card], duration: TimeInterval = 2) -> some View {
        modifier(HintToastModifier(isShowing: isShowing, cards: cards, duration: duration))
    }
}
