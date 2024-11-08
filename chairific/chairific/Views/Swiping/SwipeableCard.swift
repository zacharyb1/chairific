//
//  SwipeableCard.swift
//  chairific
//
//  Created by Jules Morillon on 8.11.2024.
//

import SwiftUI

struct SwipeableCard: Identifiable, View {
    let id: String
    let content: String
    let color: Color
    
    var body: some View {
        Text(self.content)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(self.color)
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding(10)
    }
}

#Preview {
    SwipeableCard(id: "0", content: "Card preview", color: baseButtonColor)
}
