import SwiftUI
import OpenTDB

struct QuizView: View {
  let api = Trivia.shared
  let category: Trivia.Category
  @State var questions: [Trivia.Question] = []
  @State var answers: [Trivia.Question.ID: String] = [:]
  @State var sheet = false
  @Environment(\.dismiss) var dismiss

  var body: some View {
    List {
      ForEach(
        Array(self.questions.enumerated()), id: \.element
      ) { index, question in
        Section(
          header: Text("\(index+1). \(question.formattedQuestion)")
            .textCase(.none)
        ) {
          ForEach(question.answers, id: \.self) { answer in
            Button {
              answers[question.id] = answer
            } label: {
              HStack {
                Text(answer)
                
                if answers[question.id] == answer {
                  Image(systemName: "checkmark")
                }
              }
            }
          }
        }
      }
    }
    .navigationTitle(self.category.formattedName)
    .navigationBarTitleDisplayMode(.inline)
    .listStyle(.grouped)
    .sheet(isPresented: $sheet) {
      ResultsSheet {
        self.sheet = false
        self.dismiss()
      }
    }
    .toolbar {
      Button("Finish") {
        self.sheet = true
      }
    }
    .task {
      do {
        self.questions = try await api.fetchQuestions(
          categoryId: self.category.id
        ).results
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

#Preview {
  NavigationStack {
    QuizView(category: .previewValue)
  }
}
