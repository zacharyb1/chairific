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
    
    var handleSwipe: (CGFloat) -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    handleSwipe(-UIScreen.main.bounds.width * 2)
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 38, height: 38)
                        .foregroundColor(.red)
                        .padding()
                        .background(Circle().fill(Color(.systemGray5)))
                }
                Spacer()
                Button(action: {
                    showMore = true
                }) {
                    HStack {
                        Text("More")
                            .font(.system(size: 26, weight: .semibold))
                            .foregroundColor(Color(.systemGray2))
                        
                        Image(systemName: "chevron.up.2")
                            .foregroundColor(baseButtonColor)
                    }
                    .frame(width: 100, height: 40)
                    .padding(6)
                    .background(Rectangle().fill(Color(.systemGray5)))
                    .cornerRadius(10)
                }
                Spacer()
                Button(action: {
                    handleSwipe(UIScreen.main.bounds.width * 2)
                }) {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 38, height: 38)
                        .foregroundColor(Color("lightorange"))
                        .padding()
                        .background(Circle().fill(Color(.systemGray5)))
                }
                Spacer()
            }
            .padding(.bottom, 30)
        }
    }
}
