# 4. Fetching categories from the Api

The first feature that we need for our app is the ability to fetch a list of categories from the open trivia API. 

![Demo](./swift_14.png)

## 1. Importing OpenTDB

Let's start by importing OpenTDB. This is how we will get access to all of the functions and classes within this package.

```swift
import SwiftUI
import OpenTDB
```

## 2. Creating the Singleton

The actual object that fetches data is called `OpenTDBClient`. Let's create a static shared value so that it can be used throughout the app. 

```swift
extension OpenTDBClient {
    static var shared = OpenTDBClient.previewValue
}
```

We can also add a type alias to make it easier to read throughout the app.

```swift
typealias Trivia = OpenTDBClient

extension Trivia {
    static var shared = OpenTDBClient.previewValue
}
```

## 3. Setting up the AppView

Now that we have a shared static value, we can add the api property to our app view, and a state property to track changes to the categories we're trying to fetch from the api.

```swift
struct AppView: View {
    let api = Trivia.shared
    @State var categories: [Trivia.Category] = []
    
    var body: some View {
        Text(...)
    }
}
```

## 4. Fetching data from the Api

The `.task` modifier allow us to perform some asynchronous logic before the view appears. In this case fetching the categories from the API. If the function does not throw an error, we will update our state when it completes.

```swift
struct AppView: View {
    let api = Trivia.shared
    @State var categories: [Trivia.Category] = []
    
    var body: some View {
        Text(...)
            .task {
                do {
                    self.categories = try await self.api
                      .fetchAllCategories()
                      .triviaCategories
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}
```

## 5. Presenting the data in a list

Now that we've actually received the values, we can put them into a `List` view, and interate over them with a `ForEach` view.

![Demo](./swift_15.png)

```swift
struct AppView: View {
    let api = Trivia.shared
    @State var categories: [Trivia.Category] = []
    
    var body: some View {
        List {
            ForEach(self.categories) { category in
                Text(category.name)
            }
        }
        .task { ... }
    }
}
```

## 6. ForEach Explained

`ForEach` View allows us to construct a unique view for each element in the collection, provided that element. 

Let's use an `HStack` to wrap the categories name and emoji.

![Demo](./swift_16.png)

```swift
ForEach(self.categories) { category in
    HStack {
        Text(category.name)
        Text(category.emoji)
    }
}
```

## 7. Navigating to the Quiz View

Let's add support for navigation to the quiz view for each category. To do this we need:
1. `NavigationStack` - A view that displays a root view and enables you to present additional views over the root view.
2. `NavigationLink` - A view that controls a navigation presentation.
3. `.navigationTitle` - A view modifier that configures the view’s title for purposes of navigation.

Let's wrap our List view in the NavigationStack, wrap our category views in NavigationLinks, and add a navigationTitle to the List.

![Demo](./NavigationStack.gif)

```swift
struct AppView: View {
    let api = Trivia.shared
    @State var categories: [Trivia.Category] = []
    
    var body: some View {
       // 1. NavigationStack
        NavigationStack {
            List {
                ForEach(self.categories) { category in
                    // 2. NavigationLink
                    NavigationLink(
                        destination: {
                            Text("Quiz for \(category.name)")
                        },
                        label: {
                            HStack {
                                Text(category.name)
                                Text(category.emoji)
                            }
                        }
                    )
                }
            }
            // 3. navigationTitle
            .navigationTitle("Trivia")
            .task { ... }
        }
    }
}
```

## 🎉 Finished!

In the next section, we will start building the actual Quiz.