//
//  RecordView.swift
//  Combination
//
//  Created by 이정원 on 2022/08/01.
//

import SwiftUI

struct RecordView: View {
    let viewModel: RecordViewModel
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(viewModel.date)
                .font(.system(size: 20))
                .fontWeight(.medium)
                .padding(4)
            Divider()
            HStack {
                VStack {
                    Text("시간")
                        .fontWeight(.medium)
                        .font(.system(size: 20))
                        .padding(.vertical, 2)
                    Text(viewModel.elapsedTime)
                        .font(.notoSans(size: 20))
                }
                .frame(maxWidth: .infinity)
                Divider()
                VStack {
                    Text("점수")
                        .fontWeight(.medium)
                        .font(.system(size: 20))
                        .padding(.vertical, 2)
                    Text(viewModel.score)
                        .font(.notoSans(size: 20))
                }
                .frame(maxWidth: .infinity)
            }
            Divider()
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("총 합 개수")
                        .fontWeight(.medium)
                        .font(.system(size: 20))
                    Spacer()
                    Text(viewModel.numberOfAnswer)
                        .font(.notoSans(size: 18))
                }
                HStack {
                    Text("총 시도 횟수")
                        .fontWeight(.medium)
                        .font(.system(size: 20))
                    Spacer()
                    Text(viewModel.trialCount)
                        .font(.notoSans(size: 18))
                }
                HStack {
                    Text("힌트 참고 횟수")
                        .fontWeight(.medium)
                        .font(.system(size: 20))
                    Spacer()
                    Text(viewModel.hintCount)
                        .font(.notoSans(size: 18))
                }
            }
        }
        .padding()
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(
            viewModel: RecordViewModel(
                record: Record(
                    date: Date(),
                    elapsedSeconds: 523,
                    score: 31,
                    numberOfAnswer: 42,
                    trialCount: 61,
                    hintCount: 26
                )
            )
        )
    }
}
