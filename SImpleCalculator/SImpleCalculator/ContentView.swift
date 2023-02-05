import SwiftUI

struct ContentView: View {
    @State private var firstNum = ""
    @State private var secondNum = ""
    @State private var operation = ""
    @State private var result: Double?

    private func calculate() {
        guard let num1 = Double(firstNum), let num2 = Double(secondNum) else { return }

        switch operation {
        case "+":
            result = num1 + num2
        case "-":
            result = num1 - num2
        case "*":
            result = num1 * num2
        case "/":
            result = num1 / num2
        default:
            break
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("First number:")
                TextField("Enter a number", text: $firstNum, onCommit: {
                    if let value = Double(self.firstNum) {
                        self.firstNum = String(value)
                    } else {
                        self.firstNum = ""
                    }
                })
            }
            HStack {
                Text("Second number:")
                TextField("Enter a number", text: $secondNum, onCommit: {
                    if let value = Double(self.secondNum) {
                        self.secondNum = String(value)
                    } else {
                        self.secondNum = ""
                    }
                })
            }
            HStack {
                Text("Operation:")
                TextField("Enter an operation (+, -, *, /)", text: $operation)
            }
            Button(action: {
                self.calculate()
            }) {
                Text("Calculate")
            }
            if result != nil {
                Text("Result: \(result!)")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

