//
//  EntryQuestionnaireView.swift
//  chairific
//
//  Created by Jules Morillon on 8.11.2024.
//


import SwiftUI

// Step for managing the questionnaire flow
enum QuestionnaireStep {
    case welcome
    case intro
    case questions
    case complete
}

struct EntryQuestionnaireView: View {
    // State for current step and personal information
    @State private var currentStep: QuestionnaireStep = .welcome
    @State private var name = ""
    @State private var surname = ""
    @State private var city = ""
    @State private var currentQuestionIndex = 0
    @State private var isCurrentQuestionCompleted: Bool = false
    @Environment(\.dismiss) var dismiss
    
    // Questions for the questionnaire
    private var questions: [QuestionView] {
        [
            QuestionView(question: "Does the office location matter?", options: ["Yes", "No"], isCompleted: $isCurrentQuestionCompleted),
            QuestionView(question: "How comfortable are you with remote work?", options: ["Very comfortable", "Somewhat comfortable", "Not comfortable"], isCompleted: $isCurrentQuestionCompleted),
            QuestionView(question: "How important is work-life balance?", options: ["Very important", "Somewhat important", "Not important"], isCompleted: $isCurrentQuestionCompleted),
            QuestionView(question: "How often do you prefer meetings?", options: ["Daily", "Weekly", "Monthly"], isCompleted: $isCurrentQuestionCompleted),
            QuestionView(question: "Do you value flexible working hours?", options: ["Yes", "No"], isCompleted: $isCurrentQuestionCompleted)
        ]
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(titleForCurrentStep)
                    .font(.largeTitle)
                    .padding(.bottom, currentStep == .questions ? 4 : 20)
                if currentStep == .questions {
                    ProgressView(value: Double(currentQuestionIndex) * 0.2)
                        .padding(.horizontal)
                }
            }
            .padding()
            // Main content area based on the current step
            mainContent
        }
        .padding()
    }
    
    // Determines the title based on the current step
    private var titleForCurrentStep: String {
        switch currentStep {
        case .welcome: return "Welcome to Chairific!"
        case .intro, .questions: return "Chairific Questions"
        case .complete: return "Thank you!"
        }
    }
    
    // Main content view based on the current step
    @ViewBuilder
    private var mainContent: some View {
        switch currentStep {
        case .welcome:
            welcomeView
        case .intro:
            introView
        case .questions:
            questionsView
        case .complete:
            completeView
        }
    }
    
    // Welcome step view with personal information text fields
    private var welcomeView: some View {
        VStack(spacing: 20) {
            TextField("First Name", text: $name)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            TextField("Last Name", text: $surname)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            TextField("City", text: $city)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            Button("Continue") {
                currentStep = .intro
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(name.isEmpty || surname.isEmpty || city.isEmpty)
        }
        .padding(.horizontal)
    }
    
    // Introduction step view with introductory message and Start button
    private var introView: some View {
        VStack(spacing: 20) {
            Text("We will now check your work preferences with various questions")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Start") {
                currentStep = .questions
                currentQuestionIndex = 0
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
    
    // Questions step view with navigation controls
    private var questionsView: some View {
        VStack(spacing: 20) {
            questions[currentQuestionIndex]
            
            Button("Next") {
                if currentQuestionIndex < questions.count - 1 {
                    currentQuestionIndex += 1
                    isCurrentQuestionCompleted = false // Reset for the next question
                } else {
                    currentStep = .complete
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(!isCurrentQuestionCompleted)
        }
        .padding(.horizontal)
    }
    
    // Completion view after finishing the questionnaire
    private var completeView: some View {
        VStack(spacing: 20) {
            Text("Thank you for completing the entry questionnaire!")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("You’re all set up and ready to explore Chairific.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button { dismiss() } label: {
                Text("Let´s go!")
                    .font(.system(size: 36, weight: .light))
                    .foregroundStyle(.black)
                    .padding()
                    .background(.yellow)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    EntryQuestionnaireView()
}
