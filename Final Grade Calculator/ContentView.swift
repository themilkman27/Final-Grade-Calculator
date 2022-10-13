//
//  ContentView.swift
//  Final Grade Calculator
//
//  Created by Owen Johnson on 9/28/22.
//

import SwiftUI

        struct ContentView: View {
            @State private var currentGradeTextField = ""
            @State private var finalWeightTextField = ""
            @State private var desiredGrade = 0.0
            @State private var requiredGrade = 0.0
            var body: some View {
                VStack {
                    Text("Final Grade Calculator")
                    Text("Result")
                    CustomTextField(placeholder: "Current Grade", variable: $currentGradeTextField)
                        .multilineTextAlignment(.center)
                    CustomTextField(placeholder: "Final Weight", variable: $finalWeightTextField)
                        .multilineTextAlignment(.center)
                    Text((String(round(requiredGrade)/100 * 100)))
                    Picker("Desired Semester Grade", selection: $desiredGrade) {
                        Text("A").tag(90.0)
                        Text("B").tag(80.0)
                        Text("B").tag(70.0)
                        Text("C").tag(60.0)
                        Text("D").tag(50.0)
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: desiredGrade, perform: { newValue in
                        calculateGrade()
                    })
                }
                
                
                .padding()
                .background(requiredGrade > 100 ? Color.red : Color.green.opacity(requiredGrade > 0 ? 1.0 : 0.0))
            }
            func calculateGrade() {
                if let currentGrade = Double(currentGradeTextField) {
                    if let finalWeight = Double(finalWeightTextField) {
                        if finalWeight < 100 && finalWeight > 0  {
                            let finalPercentage = finalWeight / 100.0
                            requiredGrade = max(0.0, (desiredGrade - (currentGrade * ( 1.0 - finalPercentage))) / finalPercentage)
                        }
                    }
                }
            }
        }
        
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
        
struct CustomTextField: View {
    let placeholder : String
    let variable : Binding<String>
    var body: some View {
        TextField(placeholder, text: variable)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.none)
    }
}
    
