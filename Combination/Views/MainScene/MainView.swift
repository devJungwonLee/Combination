//
//  MainView.swift
//  Combination
//
//  Created by 이정원 on 2022/06/06.
//

import SwiftUI

struct MainView: View {
    @State var isGameViewActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                LogoView()
                VStack {
                    NavigationLink(isActive: $isGameViewActive) {
                        GameView(
                            viewModel: GameViewModel(),
                            isActive: $isGameViewActive
                        )
                    } label: {
                        Text("게임 시작")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .frame(width: 200, height: 40)
                    }
                    .buttonStyle(.bordered)
                    .padding(8)
                    .navigationBarTitleDisplayMode(.inline)
                    
                    MenuButton(
                        destination: GameRuleView(),
                        title: "게임 룰"
                    )
                    MenuButton(
                        destination: RecordListView(
                            viewModel: RecordListViewModel()
                        ),
                        title: "기록"
                    )
                }
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
