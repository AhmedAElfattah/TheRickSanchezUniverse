//
//  StatusPickerView.swift
//  TheRickSanchezUniverse
//
//  Created by Ahmed MAbdelfattah on 31/05/2024.
//
import SwiftUI
struct CharacterFilterView: View {
    @ObservedObject var viewModel: CharacterFilterViewModel
    @State private var selectedStatusIndex: Int = 0
    private let statusOptions = ["Alive", "Dead", "Unknown"]
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedStatusIndex) {
                ForEach(0..<statusOptions.count, id: \.self) { index in
                    Text(statusOptions[index])
                        .padding(8)
                        .foregroundColor(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.trailing, 16)
                        .font(.caption)
                }
            }
            .padding(.trailing, 15)
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selectedStatusIndex) { newValue in
                let selectedStatus = statusOptions[newValue]
                viewModel.selectedStatus = selectedStatus
            }
        }
    }
}


struct CharacterFilterWrapperView: View {
    private var charactersFilterViewModel: CharacterFilterViewModel
    var body: some View {
        CharacterFilterView(viewModel: charactersFilterViewModel)
            .edgesIgnoringSafeArea(.all)
    }
    
    init(charactersFilterViewModel: CharacterFilterViewModel) {
        self.charactersFilterViewModel = charactersFilterViewModel
    }
}

