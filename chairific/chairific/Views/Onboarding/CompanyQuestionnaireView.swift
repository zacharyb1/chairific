//
//  EntryQuestionnaireView.swift
//  chairific
//
//  Created by Jules Morillon on 8.11.2024.
//

import SwiftUI

struct CompanyQuestionnaireView: View {
    // State for current step and personal information
    @State private var collectedAnswers: [(questionID: String, answerIndex: Int)] = []

    @State private var currentStep: QuestionnaireStep = .intro
    @State private var currentQuestionIndex = 0

    @State private var isCurrentQuestionCompleted: Bool = false
    @AppStorage("isUserAnswers") private var isUserAnswers: Bool = false
    @State private var selectedAnswerIndex: Int? = nil
    
    @State private var questions: [QuestionView] = []
    private var numberOfMendatoryQuestions: Int = 10
    @State var firstLogin: Bool

    // Custom initializer
    init(firstLogin: Bool) {
        self._firstLogin = State(initialValue: firstLogin)
        if !firstLogin{
            numberOfMendatoryQuestions = 44
        }
    }
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            VStack {
                Text(titleForCurrentStep)
                    .font(.largeTitle)
                    .padding(.bottom, currentStep == .questions ? 4 : 20)
                if currentStep == .questions {
                    ProgressView(value: Double(currentQuestionIndex) * 1/Double(numberOfMendatoryQuestions))
                        .padding(.horizontal)
                }
            }
            .padding()

            // Main content area based on the current step
            mainContent
        }
        .onAppear {
            loadQuestions()
            if !firstLogin{
                currentStep = .questions
//                collectedAnswers =
            }
            currentQuestionIndex = UserManager.shared.usersResponses.count
            
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
    
    // Determines the title based on the current step
    private var titleForCurrentStep: String {
        switch currentStep {
        case .intro, .questions: return "Chairific Questions"
        case .complete: return "Thank you!"
        }
    }

    // Main content view based on the current step
    @ViewBuilder
    private var mainContent: some View {
        switch currentStep {
        case .intro:
            introView
        case .questions:
            questionsView
        case .complete:
            completeView
        }
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
            if !questions.isEmpty {
                questions[currentQuestionIndex]
                HStack{
                    Button("Next") {
                        saveAnswer(answerIndex: selectedAnswerIndex)
                        UserManager.shared.usersResponses = Dictionary(uniqueKeysWithValues: collectedAnswers)
                        selectedAnswerIndex = nil
                        if currentQuestionIndex < numberOfMendatoryQuestions {
                            currentQuestionIndex += 1
                            isCurrentQuestionCompleted = false // Reset for the next question
                        } else {
                            isUserAnswers = true
                            currentStep = .complete
                            CompanyManager.shared.uploadCollectedAnswers(collectedAnswers: collectedAnswers)
                        }
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .disabled(!isCurrentQuestionCompleted)
                }
            }
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
                    .cornerRadius(10)            }
        }
    }
    
    private func saveAnswer(answerIndex: Int?) {
        guard let index = answerIndex else { return }
        let questionID = questions[currentQuestionIndex].id
        collectedAnswers.append((questionID: questionID, answerIndex: index))
    }
    
    private func loadQuestions(){
        QuestionsManager.shared.loadQuestionsFromJSON(isEmployee: false) { loadedQuestions in
            questions = loadedQuestions.map { questionView in
                QuestionView(
                    id: questionView.id,
                    question: questionView.question,
                    options: questionView.options,
                    isCompleted: $isCurrentQuestionCompleted,
                    selectedAnswerIndex: $selectedAnswerIndex
                )
            }
        }
    }
}

//#Preview {
//    EntryQuestionnaireView(firstLogin: false)
//}
