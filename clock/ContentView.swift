import SwiftUI

struct ContentView: View {
    @State var time = Date()
    @State var color = Color.red
    
    var body: some View {
        VStack {
            Text("\(time, formatter: dateFormatter)")
                .font(.system(size: 80))
                .foregroundColor(color)
                .padding(.top, 50)
            Button("Change Color") {
                self.color = Color.random()
            }
            .padding(.top, 50)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear(perform: {
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.time = Date()
            }
            RunLoop.current.add(timer, forMode: .common)
        })
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
}

extension Color {
    static func random() -> Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
}

