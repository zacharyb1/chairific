//
//  CardDetailsCompanyView.swift
//  chairific
//
//  Created by Ivan Semeniuk on 09/11/2024.
//

import SwiftUI

struct CardDetailsCompanyView: View {
    let jobCard: EmployeeCard
    @Environment(\.presentationMode) var presentationMode // For dismissing the view
    @State private var questionViews: [QuestionView] = []
    
    // Define grid layout with a single flexible column for left alignment
    private let gridLayout = [GridItem(.flexible())]
    
    var body: some View {
        VStack {
            // Close button at the top right
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss the view
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            
            ScrollView {
                VStack(spacing: 20) {
                    // Similarity Circle
                    ZStack {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 100, height: 100)
                        
                        Text("\(Int(jobCard.similarity ?? 0))%")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                    
                    // Position and Industry
                    VStack(spacing: 5) {
                        Text(jobCard.position)
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(.primary)

                    }
                    .padding(.bottom, 10)
                    
                    // Position Hard Skills with Matching Overlay
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(spacing: 10) {
                            ForEach(jobCard.positionHardSkills, id: \.self) { skill in
                                Text(skill)
                                    .font(.system(size: 20, weight: .regular))
                                    .lineLimit(1) // Ensure text stays on one line
                                    .minimumScaleFactor(0.5) // Scale down to 50% of the original size if needed
                                    .padding(10)
                                    .background(
                                        jobCard.emplyeeHardSkills.contains(skill) ? Color.orange.opacity(0.6) : Color.clear
                                    )
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(
                                                jobCard.emplyeeHardSkills.contains(skill) ? Color.orange : Color.primary.opacity(0.2),
                                                lineWidth: 2
                                            )
                                    )
                            }
                        }
                    }



                    .padding(.bottom, 20)
                    
                    // Sections Grid with Left Alignment
                    if let hobbies = jobCard.employeeDetails["hobbies"] as? [String], !hobbies.isEmpty {
                        LazyVGrid(columns: gridLayout, alignment: .leading, spacing: 20) {
                            // Culture Section
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Hobbies:")
                                    .font(.system(size: 30, weight: .semibold))
                                    .foregroundColor(.primary)
                                
                                ForEach(hobbies, id: \.self) { point in
                                    Text("+ \(point)")
                                        .font(.system(size: 20, weight: .regular))
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.bottom, 10)
                        }
                    }

                    
                    // Matching Questions Section
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("Matching Choices")
//                            .font(.system(size: 30, weight: .semibold))
//                            .foregroundColor(.primary)
//                        
//                        ForEach(matchingQuestionViews, id: \.id) { questionView in
//                            VStack(alignment: .leading, spacing: 5) {
//                                Text("Q: \(questionView.question)")
//                                    .font(.system(size: 20, weight: .semibold))
//                                    .foregroundColor(.primary)
//                                
//                                if let selectedAnswerIndex = jobCard.responses[questionView.id] {
//                                    Text("A: \(questionView.options[selectedAnswerIndex])")
//                                        .font(.system(size: 18, weight: .regular))
//                                        .foregroundColor(.secondary)
//                                }
//                            }
//                            .padding(.bottom, 10)
//                        }
//                    }
//                    .padding(.bottom, 20)
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .navigationBarTitle("Job Details", displayMode: .inline)
        .onAppear {
//            loadQuestionViews()
        }
    }
    
    // Filter to get only matching question views based on company responses
//    private var matchingQuestionViews: [QuestionView] {
//        questionViews.filter { questionView in
//            // Cast company responses to [String: Int] and match with user responses
//            if let companyResponses = jobCard.company["responses"] as? [String: Int],
//               let companyResponse = companyResponses[questionView.id],
//               let userResponse = UserManager.shared.usersResponses[questionView.id] {
//                return companyResponse == userResponse
//            }
//            return false
//        }
//    }
//    
//    // Load questions from JSON and convert to QuestionView
//    private func loadQuestionViews() {
//        QuestionsManager.shared.loadQuestionsFromJSON(isEmployee: true) { loadedQuestionViews in
//            self.questionViews = loadedQuestionViews
//        }
//    }
}

//
//#Preview {
//    CardDetailsCompanyView()
//}
