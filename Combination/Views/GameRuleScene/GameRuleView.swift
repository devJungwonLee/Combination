//
//  GameRuleView.swift
//  Combination
//
//  Created by 이정원 on 2022/08/04.
//

import SwiftUI

struct GameRuleView: View {
    let combinations = [
        [
            Card(id: 0, shape: .circle, shapeColor: .blue, backgroundColor: .white),
            Card(id: 0, shape: .triangle, shapeColor: .red, backgroundColor: .white),
            Card(id: 0, shape: .square, shapeColor: .yellow, backgroundColor: .white)
        ],
        [
            Card(id: 0, shape: .circle, shapeColor: .blue, backgroundColor: .white),
            Card(id: 0, shape: .triangle, shapeColor: .blue, backgroundColor: .gray),
            Card(id: 0, shape: .square, shapeColor: .blue, backgroundColor: .black)
        ],
        [
            Card(id: 0, shape: .circle, shapeColor: .blue, backgroundColor: .white),
            Card(id: 0, shape: .triangle, shapeColor: .yellow, backgroundColor: .gray),
            Card(id: 0, shape: .square, shapeColor: .red, backgroundColor: .black)
        ]
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text("결합은 주어진 9개의 카드 중에서 **합**을 최대한 찾는 게임입니다. 게임은 총 **10 라운드**로 이루어져 있으며 매 라운드마다 9개의 카드가 바뀝니다.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                    Text("**합**은 세 카드를 조합했을 때 **도형, 도형색, 배경색이 모두 같거나 다 다른 경우**를 말합니다.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                }
                Divider()
                VStack {
                    Text("다음 그림은 합을 나타내는 예시입니다.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                    CombinationView(cards: combinations[0], title: "도형, 도형색이 다 다르고, 배경색이 같은 경우")
                    CombinationView(cards: combinations[1], title: "도형색이 같고, 도형, 배경색이 다 다른 경우")
                    CombinationView(cards: combinations[2], title: "도형, 도형색, 배경색이 다 다른 경우")
                    Text("이외에도 합이 되는 조합은 다양하게 있습니다.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                }
                Divider()
                VStack {
                    Text("주어진 9개의 카드에서 **합을 모두 찾은 경우**를 **결**이라고 하며, 이 때 결 버튼을 누르게 되면 다음 라운드로 넘어갈 수 있습니다.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                }
                Divider()
                VStack{
                    Text("점수 산정 방식은 다음과 같습니다.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                    Text("하나의 합을 찾을 때마다 **1점**을 획득하게 되며, 결인 상황에서 결 버튼을 누르는 경우 **3점**을 획득하게 됩니다.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                    Text("단, 합이 아닌 조합을 선택하는 경우, 이미 찾은 합을 다시 선택하는 경우, 결이 아닌 상황에서 결 버튼을 누르는 경우에는 **1점**을 잃게 됩니다.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                    Text("또한, 힌트를 참고하는 경우에도 **1점**을 잃게 됩니다.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                }
            }
            .padding(.horizontal, 20)
            .lineSpacing(8)
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("게임 룰")
    }
}

struct CombinationView: View {
    let cards: [Card]
    let title: String
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                CardView(card: cards[0])
                CardView(card: cards[1])
                CardView(card: cards[2])
            }
            .frame(height: 60)
            Text(title)
                .font(.system(size: 16))
                .padding(.vertical)
        }
        .padding(.vertical)
    }
}

struct GameRulView_Previews: PreviewProvider {
    static var previews: some View {
        GameRuleView()
    }
}
