//
//  ResultsView.swift
//

import SwiftUI

struct ResultsView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var results: Results?
    var body: some View {
        ZStack {
            Background(image: BgImage.peoples)
            if let results = results {
                ScrollView {
                    ForEach(results.resulsArray, id: \.id) { result in

                        if result.name != "" {
                            HStack {
                                Text(result.name)
                                Spacer()
                                Text(String(result.score))
                            }
                            .padding(10)
                            .background(Gradients.blue)
                            .clipShape(.rect(cornerRadius: 16))
                            .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            results = UserDefaultService.shared.getStructs(forKey: "Result")
        }
        .overlay(alignment: .topTrailing) {
            DismissBtn()
        }
        .navigationBarHidden(true)
    }
    
}

#Preview {
    ResultsView()
}
