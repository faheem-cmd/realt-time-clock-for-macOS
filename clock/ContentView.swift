import SwiftUI

struct ContentView: View {
    @State private var timeInterval = Date().timeIntervalSinceReferenceDate
    @State private var color = Color.red
    @State private var quote = ""
    @State private var quoteOffset = CGSize.zero
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let quotes = ["The only way to do great work is to love what you do.", "Don't watch the clock; do what it does. Keep going.", "The future depends on what you do today.", "Believe you can and you're halfway there.", "Success is not final, failure is not fatal: It is the courage to continue that counts."]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [color, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .animation(.easeInOut(duration: 2))
                .ignoresSafeArea()
            
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 8)
                .frame(width: 200, height: 200)
            
            Circle()
                .trim(from: 0, to: CGFloat(timeInterval.truncatingRemainder(dividingBy: 60)) / 60)
                .stroke(color, lineWidth: 8)
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1))
            
            VStack {
                Text("\(timeString(time: Date(timeIntervalSinceReferenceDate: timeInterval)))")
                    .font(.system(size: 32))
                    .foregroundColor(color)
                    .fontWeight(.bold)
                    .animation(.easeInOut(duration: 2))
                
                Text("\(dateString(date: Date()))")
                    .font(.custom("Helvetica Neue", size: 20))
                    .foregroundColor(.black)
                    .id(dateString(date: Date()))
                    .transition(.opacity)
                
                Text("\(quote)")
                    .font(.custom("Helvetica Neue", size: 20))
                    .foregroundColor(.white)
                    .offset(quoteOffset)
                    .animation(Animation.linear(duration: 5).repeatForever(autoreverses: true))
                    .onAppear(perform: { randomizeQuote() })
            }
        }
        .onReceive(timer) { input in
            self.timeInterval = input.timeIntervalSinceReferenceDate
            self.color = Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    func timeString(time: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: time)
    }
    
    func dateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    func randomizeQuote() {
        self.quote = self.quotes.randomElement() ?? ""
        self.quoteOffset = CGSize(width: CGFloat.random(in: -150...150), height: CGFloat.random(in: -150...150))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

