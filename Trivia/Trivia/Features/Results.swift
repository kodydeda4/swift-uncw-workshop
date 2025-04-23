import SwiftUI
import OpenTDB

struct ResultsSheet: View {
    let questions: [Trivia.Question]
    let answers: [Trivia.Question.ID: String]
    var finishButtonTapped: () -> Void = {}
    
    var correctCount: Int {
        questions.filter { question in
            question.correctAnswer == answers[question.id]
        }
        .count
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("🎉 Finished!").bold()
                GroupBox {
                    VStack(alignment: .leading) {
                        Text("Correct: \(correctCount)")
                        Divider()
                        Text("Total: \(questions.count)")
                    }
                }
                
                Button {
                    self.finishButtonTapped()
                } label: {
                    Text("Finish")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 8)
            }
            .padding()
            .font(.title2)
            .navigationTitle("Results")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    Text("Hello World").sheet(isPresented: .constant(true)) {
        ResultsSheet(
            questions: .previewValue,
            answers: .previewValue
        )
    }
}


