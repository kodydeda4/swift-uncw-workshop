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

extension OpenTDBClient {
    static var shared = OpenTDBClient.liveValue
}

typealias Trivia = OpenTDBClient
