//
//  AllQuestionsView.swift
//

import SwiftUI

struct AllQuestionsView: View {
    @ObservedObject var viewModel: AllQuestionsViewModel
    @State var isBlinking = true
    var body: some View {
        ZStack {
            Background(image: BgImage.empty)
            
            VStack {
                ForEach(1..<16) { index in
                    if viewModel.numberQuestion == 16 - index {
                        QuestionPlank(number: 16 - index, summ: allQuestions[index-1].summ, bg: viewModel.state == .successAnswer ? Gradients.green : Gradients.red)
                            .scaleEffect(isBlinking ? 1.05 : 1.0)
                            .animation(Animation.easeInOut(duration: 0.2))
                            .onAppear() {
                                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
                                    self.isBlinking.toggle()
                                }
                            }
                        
                    } else {
                        QuestionPlank(number: 16 - index, summ: allQuestions[index-1].summ, bg: allQuestions[index-1].bg)
                    }
                }
            }
        }
    }
}

#Preview {
    AllQuestionsView(viewModel: .init(state: .successAnswer, numberQuestion: 15))
}
