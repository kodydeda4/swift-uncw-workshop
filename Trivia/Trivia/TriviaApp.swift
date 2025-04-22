import SwiftUI
import OpenTDB

typealias Trivia = OpenTDBClient
extension Trivia { static var shared = Trivia.previewValue }

@main
struct TriviaApp: App {
  var body: some Scene {
    WindowGroup {
      AppView()
    }
  }
}

