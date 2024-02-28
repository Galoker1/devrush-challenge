//
//  QuestionsListView.swift
//  Who Wants to Be a Millionaire?
//
//  Created by Victor on 27.02.2024.
//

import SwiftUI

struct QustionsListView: View {
    
    let current: Int
    let allAmount: [Int]
    
    init(current: Int, allAmount: [Int]) {
        self.current = current
        self.allAmount = allAmount
    }
    
    var body: some View {
        ZStack {
            Image(.emptyBackground)
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                
                ScrollViewReader {
                    value in
                    
                    ScrollView {
                        VStack {
                            ForEach(Array(zip(allAmount.indices, allAmount)).reversed(), id: \.self.0) {
                                QuestionListItem(index: $0.0, amount: $0.1, current: current)
                            }
                        }
                    }
                    .disabled(true)
                    .padding(.init(top: .zero, leading: 32, bottom: .zero, trailing: 32))
                    .onAppear {
                        value.scrollTo(current < 5 ? 0 : allAmount.count - 1)
                    }
                }
            }
        }
    }
}

struct QuestionListItem: View {
    let index: Int
    let amount: Int
    let current: Int
    
    @State var gradient: LinearGradient
    
    init(index: Int, amount: Int, current: Int) {
        self.index = index
        self.amount = amount
        self.current = current
        self.gradient = {
            if index == 4 || index == 9 {
                return current > index ? Gradients.green : Gradients.blue
            }
            if index == 14 {
                return Gradients.gold
            }
            return Gradients.purple
        }()
    }
    
    var body: some View {
        ZStack {
            gradient
            HStack {
                Text("Вопрос \(index + 1)")
                Text(amount == 1_000_000 ? "1 миллион" : "\(amount) RUB")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
            .foregroundStyle(.white)
        }
        .clipShape(.rect(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray)
        )
        .onAppear {
            withAnimation(.linear(duration: 0.25).delay(0.25)) {
                if current == index {
                    gradient = Gradients.red
                }
            }
        }
    }
}

#Preview {
    QustionsListView(
        current: 2,
        allAmount: GameService.amounts
    )
}
