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
    @State private var showCardDetails: Bool = false
    @State private var mainCardOpacity: Double = 1.0
    
    @Binding var jobCards: [JobCard]
    
    let margin: Double = 40
    let swipeThreshold: CGFloat = 200

    @State private var dragOffset: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Show the next card in the background
                if currentIndex + 1 < jobCards.count {
                    jobCards[currentIndex + 1]
                        .frame(width: geometry.size.width - margin, height: geometry.size.height - (margin * 9/16))
                        .opacity(Double(2*abs(dragOffset)) / Double(geometry.size.width))
                }
                
                // Show the current card on top
                if currentIndex < jobCards.count {
                    jobCards[currentIndex]
                        .frame(width: geometry.size.width - margin, height: geometry.size.height - (margin * 9/16))
                        .offset(x: dragOffset)
                        .opacity(mainCardOpacity)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    dragOffset = gesture.translation.width
                                    if gesture.translation.width > swipeThreshold {
                                        showApplyOverlay = true
                                    } else if gesture.translation.width < -swipeThreshold {
                                        showDenyOverlay = true
                                    } else {
                                        showApplyOverlay = false
                                        showDenyOverlay = false
                                    }
                                }
                                .onEnded { gesture in
                                    handleSwipe(gesture, geometry: geometry)
                                }
                        )
                        .animation(.spring(), value: dragOffset)
                } else {
                    Text("No more cards")
                        .frame(width: geometry.size.width - margin, height: geometry.size.height - (margin * 9/16))
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                
                if currentIndex < jobCards.count {
                    SwipingOverlay(card: jobCards[currentIndex], dragOffset: $dragOffset, showMore: $showCardDetails)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .fullScreenCover(isPresented: $showCardDetails) {
                // CardDetailsView() (@Zach)
            }
        }
    }
    
    private func handleSwipe(_ gesture: DragGesture.Value, geometry: GeometryProxy) {
        // Animation isnt fully functional
        if gesture.translation.width > swipeThreshold {
            withAnimation(.easeOut(duration: 0.5)) {
                dragOffset = geometry.size.width * 2
            }
            mainCardOpacity = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                dragOffset = 0
                currentIndex += 1
                mainCardOpacity = 1
            }
        } else if gesture.translation.width < -swipeThreshold {
            withAnimation(.easeOut(duration: 0.5)) {
                dragOffset = geometry.size.width * -2
            }
            mainCardOpacity = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                dragOffset = 0
                currentIndex += 1
                mainCardOpacity = 1
            }
        } else {
            // Reset position if swipe was too small
            dragOffset = 0
        }
    }
}

#Preview {
    SwipingView(jobCards: .constant([]))
}
