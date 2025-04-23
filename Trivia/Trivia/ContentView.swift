import SwiftUI

struct ContentView: View {
    @State var buttonTapped = false
    
    var body: some View {
        Button {
            self.buttonTapped.toggle()
        } label: {
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .foregroundColor(buttonTapped ? .black : .white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    LinearGradient(
                        colors: buttonTapped
                        ? [.blue, .purple]
                        : [.orange, .red]
                        ,
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                }
        }
        .buttonStyle(.plain)
    }
}



#Preview {
    ContentView()
}

