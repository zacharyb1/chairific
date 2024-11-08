//
//  QuestionView.swift
//  chairific
//
//  Created by Jules Morillon on 8.11.2024.
//

import SwiftUI

struct QuestionView: View {
    let question: String
    let options: [String]
    @Binding var isCompleted: Bool
    
    @State private var selectedOption: String = ""
    @State private var customAnswer: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question)
                .font(.title2)
                .padding(.bottom, 10)
            
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                    isCompleted = true
                }) {
                    HStack {
                        Text(option)
                        Spacer()
                        Image(systemName: selectedOption == option ? "checkmark.circle.fill" : "circle")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
            }
            
            // Custom answer option
            Button(action: {
                selectedOption = "Custom"
            }) {
                HStack {
                    Text("Custom")
                    Spacer()
                    Image(systemName: selectedOption == "Custom" ? "checkmark.circle.fill" : "circle")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            if selectedOption == "Custom" {
                TextField("Enter your answer", text: $customAnswer)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    .onChange(of: customAnswer) { newValue in
                        isCompleted = !newValue.isEmpty
                    }
            }
        }
        .padding()
    }
}

#Preview {
    QuestionView(
        question: "How important is work-life balance?",
        options: ["Very important", "Somewhat important", "Not important"],
        isCompleted: .constant(false)
    )
}
