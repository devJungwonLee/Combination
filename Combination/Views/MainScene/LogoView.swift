//
//  LogoView.swift
//  Combination
//
//  Created by 이정원 on 2022/06/10.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.blue)
                Triangle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.red)
                Rectangle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.yellow)
                    .padding(.leading, 8)
            }
            Text("결합")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding(.top, 20)
        }
    }
}
