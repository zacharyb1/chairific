//
//  SwipeableCard.swift
//  chairific
//
//  Created by Jules Morillon on 8.11.2024.
//

import SwiftUI

struct JobCard: Identifiable, View {
    let id: String
    let position: Dictionary<String, Any>
    let company: Dictionary<String, Any>
    // @State var matchingQuestions: Dictionary<String, Any> = [:]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 320, height: 320)
                    
                    Text("69%")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Text(self.position["position"] as? String ?? "")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(baseButtonColor)
                
                Text("in \(self.company["industry"] as? String ?? "")")
                    .font(.system(size: 20, weight: .light))
                    .foregroundStyle(baseButtonColor)
                    .padding(.bottom, 10)
                
                Text("Culture")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(baseButtonColor)
                
                ForEach(self.company["culture"] as? [String] ?? [], id: \.self) { point in
                    Text("+ \(point)")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(baseButtonColor)
                }
                .padding(.bottom, 10)
                
                ForEach(self.company["benefits"] as? [String] ?? [], id: \.self) { benefit in
                    Text("+ \(benefit)")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(baseButtonColor)
                }
                .padding(.bottom, 10)
                
                /*ForEach(self.matchingQuestions as Dictionary<String, Any>, id: \.self) { point in
                    Text("+ \(point)")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(baseButtonColor)
                }
                .padding(.bottom, 10) */
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(.orange)
        .background(.white)
        .onAppear() {
            // fetchMatchingQuestions(positionId: self.id)
        }
    }
    
    static func generateJobCard(position: Dictionary<String, Any>, completion: @escaping (Result<JobCard, Error>) -> Void) {
        FirestoreManager.shared.fetchCompany(fromId: position["companyId"] as? String ?? "") { result in
            switch result {
            case .success(let company):
                completion(.success(JobCard(id: position["id"] as? String ?? "", position: position, company: company)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

#Preview {
    JobCard(id: "0", position: [:], company: [:])
}