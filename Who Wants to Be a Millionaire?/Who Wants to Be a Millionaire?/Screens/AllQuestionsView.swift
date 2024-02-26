//
//  AllQuestionsView.swift
//

import SwiftUI

struct AllQuestionsView: View {
    var body: some View {
        ZStack {
            Background(image: BgImage.empty)
            
            VStack {
                ForEach(1..<16) { index in
                    QuestionPlank(number: 16 - index, summ: allQuestions[index-1].summ, bg: allQuestions[index-1].bg)
                }
            }
        }
    }
}

#Preview {
    AllQuestionsView()
}
