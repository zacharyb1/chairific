////
////  SeatsCompanyView.swift
////  chairific
////
////  Created by Ivan Semeniuk on 09/11/2024.
////
//
//import SwiftUI
//
//struct SeatsCompanyView: View {
//    // State variable to hold fetched position matches (currently empty)
//    @Binding var matches: [JobCard]
//    
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading, spacing: 20) {
//                Text("Your Position Matches")
//                    .font(.system(size: 32, weight: .semibold))
//                    .foregroundColor(.gray)
//                    .padding([.top, .leading])
//                
//                Spacer()
//                
//                if matches.isEmpty {
//                    VStack {
//                        Spacer()
//                        Text("You don't have any match yet")
//                            .font(.system(size: 18, weight: .regular))
//                            .foregroundColor(.gray)
//                            .multilineTextAlignment(.center)
//                            .padding()
//                        Spacer()
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                } else {
//                    ScrollView {
//                        ForEach(matches) { match in
//                            SeatRowView(match: match)
//                                .padding(.horizontal)
//                        }
//                    }
//                }
//            }
//            .background(Color(.systemGray6))
//        }
//    }
//}
//
//struct SeatRowView: View {
//    let match: JobCard
//    
//    var body: some View {
//        HStack {
//            ZStack {
//                Circle()
//                    .fill(Color.orange)
//                    .frame(width: 50, height: 50)
//                Text("\(Int((match.similarity?.isFinite == true ? match.similarity! : 0)))%")
//                    .font(.system(size: 18, weight: .bold))
//                    .foregroundColor(.white)
//            }
//            
//            VStack(alignment: .leading) {
//                Text(match.position["position"] as? String ?? "")
//                    .font(.system(size: 18, weight: .semibold))
//                    .foregroundColor(.gray)
//                
//                Text("in \(match.company["industry"] as? String ?? "")")
//                    .font(.system(size: 14))
//                    .foregroundColor(.gray)
//            }
//            
//            Spacer()
//            
//            Text("Reveal & Finalize")
//                .font(.system(size: 16, weight: .semibold))
//                .foregroundColor(.orange)
//        }
//        .padding()
//        .background(Color("backgroundColor"))
//        .cornerRadius(15)
//        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
//    }
//}
//
//#Preview {
//    SeatsCompanyView()
//}
