import SwiftUI
import OpenTDB

struct ResultsSheet: View {
  let questions: [Trivia.Question]
  let answers: [Trivia.Question.ID: String]
  var finishButtonTapped: () -> Void = {}

  var correctAnswersCount: Int {
    var count = 0
    
    for question in questions {
      if question.correctAnswer == answers[question.id] {
        count += 1
      }
    }
    
    return count
  }
  
  var body: some View {
    NavigationStack {
      Group {
        VStack(spacing: 24) {
          Text("🎉 Finished!")
            .font(.title)
            .bold()
          
          GroupBox {
            Group {
              Text(correctAnswersCount.description) +
              Text("/") +
              Text(questions.count.description) +
              Text(" Correct")
            }
            .frame(maxWidth: .infinity)
          }
          .font(.title2)
          .fontWeight(.semibold)
          .foregroundStyle(.secondary)
          
          Button {
            self.finishButtonTapped()
          } label: {
            Text("Finish")
              .fontWeight(.semibold)
              .padding(12)
              .frame(maxWidth: .infinity)
          }
          .buttonStyle(.borderedProminent)
        }
        .frame(width: 250)
      }
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
