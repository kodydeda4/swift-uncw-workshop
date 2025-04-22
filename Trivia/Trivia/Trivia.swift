import OpenTDB

typealias Trivia = OpenTDBClient

extension OpenTDBClient {
  static var shared: OpenTDBClient { .init() }
}

// @DEDA
// - [ ] TrivaDb.previewValue's
// - [ ] formattedAnswer
// - [ ] preview value for quiz results

extension Trivia.Category {
  static var previewValue: Self {
    Trivia.Category(
      id: 9,
      name: "General Knowledge"
    )
  }
}
