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
            ForEach(self.questions) { question in
                Section {
                    ForEach(question.answers, id: \.self) { answer in
                        self.answerView(question, answer)
                    }
                } header: {
                    Text(question.question)
                        .textCase(.none)
                }
            }
        }
        .navigationTitle("\(category.emoji) \(category.name)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Finish") {
                self.sheet = true
            }
        }
        .sheet(isPresented: $sheet) {
            ResultsSheet(
                questions: self.questions,
                answers: self.answers,
                finishButtonTapped: {
                    self.sheet = false
                    self.dismiss()
                }
            )
        }
        .listStyle(.grouped)
        .task {
            do {
                self.questions = try await self.api.fetchQuestions(categoryId: self.category.id).results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func answerView(
        _ question: Trivia.Question,
        _ answer: String
    ) -> some View {
        let isSelected = self.answers[question.id] == answer
        
        return Button {
            self.answers[question.id] = answer
        } label: {
            HStack {
                Text(answer)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
        }
        .foregroundColor(isSelected ? .accentColor : .primary)
    }
}

#Preview {
    NavigationStack {
        QuizView(category: Trivia.Category.previewValue)
    }
}

