import SwiftUI

struct ContentView: View {
    @State private var inputText = ""
    @State private var result: String = ""
    let calculator = StringCalculator()

    var body: some View {
        VStack(spacing: 20) {
            Text("🧮 String Calculator")
                .font(.title)
                .bold()

            TextField("Enter numbers", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Calculate") {
                do {
                    let sum = try calculator.add(inputText)
                    result = "Result: \(sum)"
                } catch {
                    result = error.localizedDescription
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)

            Text(result)
                .padding()
                .foregroundColor(result.contains("negative") ? .red : .green)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
