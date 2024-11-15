//
//  CardDetailsView.swift
//  chairific
//
//  Created by Zachary Burda on 8.11.2024.
//

import SwiftUI

struct CardDetailsView: View {
    let jobCard: JobCard
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
                        
                        Text("\(Int(jobCard.similarity?.isFinite == true ? jobCard.similarity! : 0))%")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 20)
                    
                    // Position and Industry
                    VStack(spacing: 5) {
                        Text(jobCard.position["position"] as? String ?? "")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        Text("in \(jobCard.company["industry"] as? String ?? "")")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 10)
                    
                    // Sections Grid with Left Alignment
                    LazyVGrid(columns: gridLayout, alignment: .leading, spacing: 20) {
                        // Culture Section
                        if let culture = jobCard.company["culture"] as? [String], !culture.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Culture")
                                    .font(.system(size: 30, weight: .semibold))
                                    .foregroundColor(.primary)
                                
                                ForEach(culture, id: \.self) { point in
                                    Text("+ \(point)")
                                        .font(.system(size: 20, weight: .regular))
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.bottom, 10)
                        }

                        
                        // Benefits Section
                        if let benefits = jobCard.company["benefits"] as? [String], !benefits.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Benefits")
                                    .font(.system(size: 30, weight: .semibold))
                                    .foregroundColor(.primary)
                                
                                ForEach(benefits, id: \.self) { benefit in
                                    Text("+ \(benefit)")
                                        .font(.system(size: 20, weight: .regular))
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.bottom, 10)
                        }

                        
                        // Glassdoor Score Section
                        if let glassdoorScore = jobCard.company["glassdoor"] as? Double {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Glassdoor Score")
                                    .font(.system(size: 30, weight: .semibold))
                                    .foregroundColor(.primary)
                                
                                Text(String(format: "%.1f", glassdoorScore))
                                    .font(.system(size: 20, weight: .regular))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.bottom, 10)
                        }
                    }
                    
                    // Matching Questions Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Matching Choices")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        ForEach(matchingQuestionViews, id: \.id) { questionView in
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Q: \(questionView.question)")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.primary)
                                
                                if let selectedAnswerIndex = jobCard.responses[questionView.id] {
                                    Text("A: \(questionView.options[selectedAnswerIndex])")
                                        .font(.system(size: 18, weight: .regular))
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.bottom, 10)
                        }
                    }
                    .padding(.bottom, 20)
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .navigationBarTitle("Job Details", displayMode: .inline)
        .onAppear {
            loadQuestionViews()
        }
    }
    
    // Filter to get only matching question views based on company responses
    private var matchingQuestionViews: [QuestionView] {
        questionViews.filter { questionView in
            // Cast company responses to [String: Int] and match with user responses
            if let companyResponses = jobCard.company["responses"] as? [String: Int],
               let companyResponse = companyResponses[questionView.id],
               let userResponse = UserManager.shared.usersResponses[questionView.id] {
                return companyResponse == userResponse
            }
            return false
        }
    }
    
    // Load questions from JSON and convert to QuestionView
    private func loadQuestionViews() {
        QuestionsManager.shared.loadQuestionsFromJSON(isEmployee: true) { loadedQuestionViews in
            self.questionViews = loadedQuestionViews
        }
    }
}
