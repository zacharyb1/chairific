//
//  SeatsView.swift
//  chairific
//
//  Created by Benoit Pennaneach on 8.11.2024.
//

import SwiftUI

struct SeatsView: View {
    let seats = [
        PositionItem(percentage: "69%", title: "Software development", industry: "entertainment"),
        PositionItem(percentage: "68%", title: "Full stack development", industry: "technology"),
        PositionItem(percentage: "60%", title: "Cyber security", industry: "technology"),
        PositionItem(percentage: "61%", title: "Web design", industry: "finance")
    ]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Your Position Matches")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(.gray)
                    .padding([.top, .leading])
                
                Spacer()
                
                ScrollView {
                    ForEach(seats) { seat in
                        SeatRowView(seat: seat)
                            .padding(.horizontal)
                    }
                }
            }
            .background(Color(.systemGray6))
        }
    }
}

struct SeatRowView: View {
    let seat: PositionItem
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 50, height: 50)
                Text(seat.percentage)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading) {
                Text(seat.title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.gray)
                
                Text("in \(seat.industry)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Replacing the message icon with "Reveal the Company" text
            Text("Reveal & Finalize")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.orange)
        }
        .padding()
        .background(Color("backgroundColor"))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct PositionItem: Identifiable {
    let id = UUID()
    let percentage: String
    let title: String
    let industry: String
}

struct SeatsView_Previews: PreviewProvider {
    static var previews: some View {
        SeatsView()
    }
}

