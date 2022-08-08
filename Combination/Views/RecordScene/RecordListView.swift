//
//  RecordListView.swift
//  Combination
//
//  Created by 이정원 on 2022/08/01.
//

import SwiftUI

struct RecordListView: View {
    @ObservedObject var viewModel: RecordListViewModel

    var body: some View {
        if viewModel.presentedRecords.isEmpty {
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()
                Text("기록이 존재하지 않습니다")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .onAppear {
                        viewModel.viewDidAppear()
                    }
            }
        } else {
            List(selection: $viewModel.selectedRows) {
                ForEach(viewModel.presentedRecords, id: \.id) { recordViewModel in
                    RecordView(viewModel: recordViewModel)
                        .padding(2)
                        .listRowBackground(Color(UIColor.systemGroupedBackground))
                        .listRowSeparator(.hidden)
                }
                .onDelete { indexSet in
                    viewModel.oneRowDeleteEventDidAppear(indexSet.first)
                }
            }
            .onAppear {
                viewModel.viewDidAppear()
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .listStyle(.plain)
            .navigationBarBackButtonHidden(viewModel.isEditing)
            .environment(\.editMode, .constant(viewModel.isEditing ? .active : .inactive))
            .animation(.spring(), value: viewModel.isEditing)
            
            .alert(isPresented: $viewModel.shouldShowAlert) {
                Alert(
                    title: Text("기록 삭제"),
                    message: Text("해당 기록을 삭제하시겠습니까?"),
                    primaryButton: .destructive(Text("삭제")) {
                        viewModel.alertDeleteButtonDidTap()
                    },
                    secondaryButton: .cancel(Text("취소"))
                )
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    if viewModel.isEditing {
                        Button {
                            viewModel.selectAllButtonDidTap()
                        } label: {
                            viewModel.isAllSelected ? Text("전체 선택 해제") : Text("전체 선택")
                        }
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if !viewModel.presentedRecords.isEmpty {
                        if !viewModel.isEditing {
                            Menu {
                                Picker("", selection: $viewModel.criterion) {
                                    ForEach(Criterion.allCases, id: \.self) { criterion in
                                        Text(criterion.name)
                                    }
                                }
                            } label: {
                                Text(viewModel.criterion.name)
                            }
                            Toggle("", isOn: $viewModel.isAscending)
                                .toggleStyle(ArrowStyle())
                        } else {
                            Button {
                                viewModel.deleteButtonDidTap()
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                        Button {
                            viewModel.editButtonDidTap()
                        } label: {
                            if viewModel.isEditing {
                                Text("완료")
                                    .fontWeight(.semibold)
                            } else {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ArrowStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        Image(systemName: configuration.isOn ? "arrow.up.circle" : "arrow.down.circle")
            .foregroundColor(Color(UIColor.systemBlue))
            .onTapGesture {
                configuration.isOn.toggle()
            }
    }
}
