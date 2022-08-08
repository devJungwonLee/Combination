//
//  MenuButton.swift
//  Combination
//
//  Created by 이정원 on 2022/06/10.
//

import SwiftUI

struct MenuButton<Destination: View>: View {
    let destination: Destination
    let title: String
    
    var body: some View {
        NavigationLink {
            destination
        } label: {
            Text(title)
                .font(.system(size: 25))
                .fontWeight(.semibold)
                .frame(width: 200, height: 40)
        }
        .buttonStyle(.bordered)
        .padding(8)
    }
}
