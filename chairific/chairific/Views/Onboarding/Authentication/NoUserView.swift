//
//  NoUserView.swift
//  chairific
//
//  Created by Zachary Burda on 10.11.2024.
//

import SwiftUI

struct NoUserView: View {
    // Sample job positions
    let samplePositions = [
        PositionItem(title: "Software Developer", industry: "Entertainment"),
        PositionItem(title: "Full Stack Developer", industry: "Technology"),
        PositionItem(title: "Cybersecurity Specialist", industry: "Technology"),
        PositionItem(title: "Web Designer", industry: "Finance")
    ]
    
    // Define grid layout with two columns
    private let gridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            // Login message
            Text("Log in or register to access all features like:")
                .font(.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.top, 20)

            VStack(alignment: .center, spacing: 5) {
                Text("• Swiping through jobs")
                Text("• AI-based matching")
                Text("• Swipe-to-apply")
                Text("• Bias-free recruitment")
                Text("and much more!")
            }
            .font(.body)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding(.bottom, 20)
            
            Text("Open Positions:")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.top, 10)
            
            // Display sample positions in a grid
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 20) {
                ForEach(samplePositions) { position in
                    VStack(alignment: .leading, spacing: 5) {
                        Text(position.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("in \(position.industry)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

struct PositionItem: Identifiable {
    let id = UUID()
    let title: String
    let industry: String
}

#Preview {
    NoUserView()
}
