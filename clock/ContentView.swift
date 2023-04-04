import SwiftUI

struct ContentView: View {
    @State private var time = ""
    @State private var textColor = Color.white
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
    
    var body: some View {
        Text(time)
            .font(.system(size: 80, weight:.regular))
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .onReceive(timer) { _ in
                let formatter = DateFormatter()
                formatter.timeStyle = .medium
                self.time = formatter.string(from: Date())
                self.textColor = colors.randomElement() ?? .white
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

