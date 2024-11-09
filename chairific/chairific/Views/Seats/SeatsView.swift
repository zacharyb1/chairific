//
//  SeatsView.swift
//  chairific
//
//  Created by Benoit Pennaneach on 8.11.2024.
//

import SwiftUI

struct SeatsView: View {
    // State variable to hold fetched position matches (currently empty)
    @Binding var matches: [JobCard]
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Your Position Matches")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(.gray)
                    .padding([.top, .leading])
                
                Spacer()
                
                if matches.isEmpty {
                    VStack {
                        Spacer()
                        Text("You don't have any match yet")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        ForEach(matches) { match in
                            SeatRowView(match: match)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .background(Color(.systemGray6))
        }
    }
}

struct SeatRowView: View {
    let match: JobCard
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 50, height: 50)
                Text("\(Int((match.similarity?.isFinite == true ? match.similarity! : 0)))%")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading) {
                Text(match.position["position"] as? String ?? "")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.gray)
                
                Text("in \(match.company["industry"] as? String ?? "")")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
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

struct SeatsView_Previews: PreviewProvider {
    static var previews: some View {
        SeatsView(matches: .constant([]))
    }
}



/*
 import SwiftUI

 struct SeatsView: View {
     // State variable to hold fetched position matches
     @State private var seats: [PositionItem] = []
     // State variable to track loading or empty state
     @State private var isLoading = true
     
     var body: some View {
         NavigationView {
             VStack(alignment: .leading, spacing: 20) {
                 Text("Your Position Matches")
                     .font(.system(size: 32, weight: .semibold))
                     .foregroundColor(.gray)
                     .padding([.top, .leading])
                 
                 Spacer()
                 
                 if isLoading {
                     ProgressView("Loading...")
                         .padding()
                         .frame(maxWidth: .infinity, alignment: .center)
                 } else if seats.isEmpty {
                     // Display message if there are no matches
                     Text("Companies haven't swiped back on your profile yet")
                         .font(.system(size: 18, weight: .regular))
                         .foregroundColor(.gray)
                         .padding()
                         .frame(maxWidth: .infinity, alignment: .center)
                 } else {
                     ScrollView {
                         ForEach(seats) { seat in
                             SeatRowView(seat: seat)
                                 .padding(.horizontal)
                         }
                     }
                 }
             }
             .background(Color(.systemGray6))
             .onAppear(perform: fetchMatches) // Fetch data when view appears
         }
     }
     
     // Function to fetch matches from the backend
     private func fetchMatches() {
         isLoading = true
         // Replace this with actual fetching logic from the cloud
         FirestoreManager.shared.fetchMatchedPositions { result in
             DispatchQueue.main.async {
                 isLoading = false
                 switch result {
                 case .success(let positions):
                     self.seats = positions.map { position in
                         PositionItem(
                             percentage: position.percentage,
                             title: position.title,
                             industry: position.industry
                         )
                     }
                 case .failure(let error):
                     print("Error fetching positions: \(error)")
                     self.seats = []
                 }
             }
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

 // Model for position item
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

 */
