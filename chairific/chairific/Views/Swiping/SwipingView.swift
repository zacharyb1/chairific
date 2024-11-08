//
//  SwipingView.swift
//  chairific
//
//  Created by Jules Morillon on 8.11.2024.
//

import SwiftUI

struct SwipingView: View {
    @State private var currentIndex = 0
    @State private var showApplyOverlay: Bool = false
    @State private var showDenyOverlay: Bool = false
    
    @Binding var jobCards: [JobCard]
    
    let margin: Double = 40
    
    @State private var dragOffset: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if currentIndex < jobCards.count {
                    jobCards[currentIndex]
                        .frame(width: geometry.size.width - margin, height: geometry.size.height - (margin * 9/16))
                        .offset(x: dragOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    dragOffset = gesture.translation.width
                                }
                                .onEnded { gesture in
                                    handleSwipe(gesture)
                                }
                        )
                        .animation(.spring(), value: dragOffset)
                } else {
                    Text("No more cards")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
        }
    }
    
    private func handleSwipe(_ gesture: DragGesture.Value) {
        let swipeThreshold: CGFloat = 200
        
        if gesture.translation.width > swipeThreshold {
            // Swiped right
            moveToNextCard()
        } else if gesture.translation.width < -swipeThreshold {
            // Swiped left
            moveToNextCard()
        } else {
            // Reset position if swipe was too small
            dragOffset = 0
        }
    }
    
    private func moveToNextCard() {
        withAnimation {
            dragOffset = 0
            currentIndex += 1
        }
    }
}

#Preview {
    SwipingView(jobCards: .constant([]))
}
