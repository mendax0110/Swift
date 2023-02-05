//
//  ContentView.swift
//  CapacitorCurve
//
//  Created by Adrian Gössl on 05.02.23.
//
import SwiftUI

struct ContentView: View {
    @State var capacitance: String = ""
    @State var voltage: String = ""
    @State var time: String = ""
    @State private var showError = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Capacitance (F):")
                TextField("Enter capacitance", text: $capacitance)
            }
            
            HStack {
                Text("Voltage (V):")
                TextField("Enter voltage", text: $voltage)
            }
            
            HStack {
                Text("Time (s):")
                TextField("Enter time", text: $time)
            }
            
            curveView
                .frame(height: 300)
            
            Button(action: {
                if let capacitance = Double(self.capacitance), let voltage = Double(self.voltage), let time = Double(self.time) {
                    let charge = capacitance * voltage
                    let discharge = charge * exp(-time / (capacitance * voltage))
                    
                    self.curveView.discharge = discharge
                    self.curveView.time = time
                } else {
                    // Show an error message to the user
                    self.showError = true
                }
            }) {
                Text("Plot Curve")
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("Error"), message: Text("Invalid input values"), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }
    
    private var curveView = CurveView()

}

struct CurveView: View {
    @State var discharge: Double = 0
    @State var time: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                let x = width * CGFloat(self.time / 10)
                let y = height - height * CGFloat(self.discharge / 10)
                path.move(to: CGPoint(x: 0, y: height))
                path.addLine(to: CGPoint(x: x, y: y))
                path.addLine(to: CGPoint(x: width, y: 0))
            }
            .fill(Color.red)
        }
    }
}
