//
//  SwipingOverlay.swift
//  chairific
//
//  Created by Jules Morillon on 8.11.2024.
//

import SwiftUI

struct SwipingOverlay: View {
    let card: JobCard
    @Binding var dragOffset: CGFloat
    @Binding var showMore: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    dragOffset = -UIScreen.main.bounds.width * 2 // Swipes card to the left
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.red)
                        .padding()
                        .background(Circle().fill(Color(.systemGray4)))
                }
                Spacer()
                Button(action: {
                    showMore = true
                }) {
                    HStack {
                        Text("More")
                            .font(.headline)
                            .foregroundColor(Color(.systemGray2))
                        Image(systemName: "chevron.up.2")
                            .foregroundColor(Color(.systemGray2))
                    }
                    .frame(width: 100, height: 40)
                    .background(Rectangle().fill(Color(.systemGray4)))
                    .cornerRadius(10)
                }
                Spacer()
                Button(action: {
                    dragOffset = UIScreen.main.bounds.width * 2
                }) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color("lightorange"))
                        .padding()
                        .background(Circle().fill(Color(.systemGray4)))
                }
                Spacer()
            }
            .padding(.bottom, 30)
        }
    }
}

#Preview {
    SwipingOverlay(card: JobCard(id: "0", position: [:], company: [:], responses: [:]), dragOffset: .constant(0), showMore: .constant(false))
}

