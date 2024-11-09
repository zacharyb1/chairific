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
                        Text(jobCard.position["position"] as? String ?? "")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        Text("in \(jobCard.company["industry"] as? String ?? "")")
                            .font(.system(size: 20, weight: .light))
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 10)
                    
                    // Culture Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Culture")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        ForEach(jobCard.company["culture"] as? [String] ?? [], id: \.self) { point in
                            Text("+ \(point)")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    // Benefits Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Benefits")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        ForEach(jobCard.company["benefits"] as? [String] ?? [], id: \.self) { benefit in
                            Text("+ \(benefit)")
                                .font(.system(size: 20, weight: .regular))
                                .foregroundColor(.secondary)
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
    }
}

struct CardDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailsView(
            jobCard: JobCard(
                id: "0",
                position: ["position": "Software Developer"],
                company: ["industry": "Entertainment", "culture": ["Cooking lunch together", "Living together", "Private rooms separated by curtains", "Cult tendencies"], "benefits": ["Shopping trips", "Saunas", "Company-provided lunch"]],
                responses: ["q1": 1],
                similarity: 69,
                hardSkills: []
            )
        )
    }
}



