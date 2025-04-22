import OpenTDB

typealias Trivia = OpenTDBClient

extension OpenTDBClient {
  static var shared: OpenTDBClient { .init() }
}

// @DEDA
// - [ ] TrivaDb.previewValue's
// - [ ] formattedAnswer
// - [ ] preview value for quiz
// - [ ] preview value for quiz results
// - [ ] remember to show logs in your presentation so you know the output...
// - [ ] Git Readme similar to Cookable

extension Trivia.Category {
  static var previewValue: Self {
    Trivia.Category(
      id: 9,
      name: "General Knowledge"
    )
  }
}

extension Array where Element == Trivia.Question {
  static var previewValue: Self {
    return [
      
    ]
  }
}

extension Dictionary where Key == Trivia.Question.ID, Value == String {
  static var previewValue: Self {
    return [
      :
    ]
  }
}

