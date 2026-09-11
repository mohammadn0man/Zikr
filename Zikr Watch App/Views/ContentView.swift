import SwiftUI

struct ContentView: View {
    @State private var count = 0
    
    var body: some View {
        VStack {
            Text("\(count)")
                .font(.system(size: 60, weight: .bold))
                .padding()
            
            Button(action: {
                count += 1
            }) {
                Text("Tap")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 44)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            
            Button(action: {
                count = 0
            }) {
                Text("Reset")
                    .foregroundColor(.red)
            }
            .padding(.top)
        }
    }
}

#Preview {
    ContentView()
}
