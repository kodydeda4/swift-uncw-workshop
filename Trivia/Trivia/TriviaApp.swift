import SwiftUI
import OpenTDB

@main
struct TriviaApp: App {
  var body: some Scene {
    WindowGroup {
      AppView()
    }
  }
}

// @DEDA
// - [x] TrivaDb.previewValue's
// - [x] formattedAnswer
// - [x] preview value for quiz
// - [x] preview value for quiz results
// - [ ] remember to show logs in your presentation so you know the output...
// - [ ] Git Readme similar to Cookable

typealias Trivia = OpenTDBClient

extension Trivia {
  static var shared = Trivia.previewValue
}
