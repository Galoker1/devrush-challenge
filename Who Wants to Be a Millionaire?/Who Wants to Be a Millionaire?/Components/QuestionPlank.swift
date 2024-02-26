//
//  QuestionPlank.swift
//

import SwiftUI

struct QuestionPlank: View {
    let number: Int
    let summ: Int
    let bg: LinearGradient
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(bg)
            .frame(height: 38)
            .overlay(alignment: .leading) {
                Text("Вопрос \(number)")
                    .foregroundStyle(.white)
                    .padding(.leading)
            }
            .overlay(alignment: .trailing) {
                Text(summ != 1000000 ? "\(summ) RUB" : "1 Миллион")
                    .foregroundStyle(.white)
                    .padding(.trailing)
            }
            .padding(.horizontal, 32)
    }
}

#Preview {
    VStack {
        QuestionPlank(number: 3, summ: 1000000, bg: Gradients.blue)
        QuestionPlank(number: 14, summ: 1000, bg: Gradients.gold)
        QuestionPlank(number: 11, summ: 1000, bg: Gradients.red)
        QuestionPlank(number: 14, summ: 1000, bg: Gradients.green)
        QuestionPlank(number: 14, summ: 5000, bg: Gradients.purple)
    }
}
