//
//  EmployeeCard.swift
//  chairific
//
//  Created by Ivan Semeniuk on 09/11/2024.
//

import SwiftUI

struct EmployeeCard: Identifiable, View {
    let id: String
    let position: String
    let employeeDetails: Dictionary<String, Any>
    let responses: [String: Int]
    var similarity: Double?
    var hardSkills: [String]
    // @State var matchingQuestions: Dictionary<String, Any> = [:]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color.orange)
                        .frame(width: 320, height: 320)
                    
                    Text("\(Int((similarity?.isFinite == true ? similarity! : 0)))%")
                        .font(.system(size: 69, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Text(position)
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundStyle(baseButtonColor)

                
                
                ForEach(hardSkills, id: \.self) { point in
                    Text("+ \(point)")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(baseButtonColor)
                }
                .padding(.bottom, 10)
                
                
//                ForEach(self.company["benefits"] as? [String] ?? [], id: \.self) { benefit in
//                    Text("+ \(benefit)")
//                        .font(.system(size: 20, weight: .regular))
//                        .foregroundStyle(baseButtonColor)
//                }
//                .padding(.bottom, 10)
                
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
    
    static func generateEmplyeeCard(employeeDetails: Dictionary<String, Any>, positionName: String, employeeUid: String, completion: @escaping (Result<EmployeeCard, Error>) -> Void) {

                let responses = employeeDetails["responses"] as? [String: Int] ?? [:]
                let hardskills = employeeDetails["skills"] as? [String] ?? []
                completion(.success(EmployeeCard(id: employeeUid, position: positionName, employeeDetails: employeeDetails, responses:responses, hardSkills: hardskills)))

    }

}
//
//#Preview {
//    EmployeeCard(id: "0", position: [:], company: [:], responses: ["q1": 1], similarity: 100, hardSkills: [])
//}

