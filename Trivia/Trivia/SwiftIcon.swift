import SwiftUI

struct SwiftIcon: View {
  @State var isDarkMode = false
  
  var body: some View {
    Button(action: { self.isDarkMode.toggle() }) {
      Image(systemName: "swift")
        .resizable()
        .scaledToFit()
        .padding(128)
        .foregroundColor(isDarkMode ? .black : .white)
        .frame(maxHeight: .infinity)
        .background {
          LinearGradient(
            colors: isDarkMode
            ? [.blue, .purple]
            : [.orange, .red]
            ,
            startPoint: .top,
            endPoint: .bottom
          )
        }
        .ignoresSafeArea()
    }
    .buttonStyle(.plain)
  }
}

#Preview {
  SwiftIcon()
}
