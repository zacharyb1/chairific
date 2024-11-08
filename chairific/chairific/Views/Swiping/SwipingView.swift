//
//  SwipingView.swift
//  chairific
//
//  Created by Jules Morillon on 8.11.2024.
//


import SwiftUI

struct SwipingView: View {
    @State private var currentIndex = 0
    let sampleCards: [SwipeableCard] = [
        SwipeableCard(id: "1", content: "Position 1", color: Color(.red)),
        SwipeableCard(id: "2", content: "Position 2", color: Color(.pink)),
        SwipeableCard(id: "3", content: "Position 3", color: Color(.blue))
    ]
    
    @State private var dragOffset: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if currentIndex < sampleCards.count {
                    sampleCards[currentIndex]
                        .frame(width: geometry.size.width, height: geometry.size.height)
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
        let swipeThreshold: CGFloat = 100
        
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
    SwipingView()
}
