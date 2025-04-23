import SwiftUI
import OpenTDB

struct AppView: View {
    let api = Trivia.shared
    @State var categories: [Trivia.Category] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Section(header: Text("Select a category").font(.headline)) {
                        LazyVGrid(columns: Array(
                            repeating: GridItem(.flexible()),
                            count: 2
                        )) {
                            ForEach(self.categories) { category in
                                NavigationLink {
                                    QuizView(category: category)
                                } label: {
                                    categoryView(category: category)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Trivia")
            .task {
                do {
                    self.categories = try await self.api.fetchAllCategories().triviaCategories
                } catch {
                    print(error.localizedDescription)
                    
                }
            }
        }
    }
    
    private func categoryView(category: Trivia.Category) -> some View {
        HStack {
            Text(category.formattedName)
            Spacer()
            Text(category.emoji)
        }
        .foregroundColor(.white)
        .padding()
        .frame(height: 80)
        .background {
            LinearGradient(
                colors: [
                    Color(emoji: category.emoji).adjustBrightness(by: 0.6),
                    Color(emoji: category.emoji).adjustBrightness(by: 0.4)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .circular))
    }
}

#Preview {
    AppView()
}
