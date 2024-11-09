//
//  CompanyMainView.swift
//  chairific
//
//  Created by Jules Morillon on 9.11.2024.
//

import SwiftUI
import FirebaseAuth

struct CompanyMainView: View {
    @State private var selectedTab: Int = 1
    let accentColor: Color = Color.orange
    let baseColor: Color = Color.white
    let tabSize: CGFloat = 30
    @State private var jobCards: [EmployeeCard] = []

    init() {
        UITabBar.appearance().backgroundColor = UIColor.figmaGrey
        UITabBar.appearance().unselectedItemTintColor = UIColor(baseColor)
    }

    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                SwipingCompanyView(jobCards: $jobCards)
                    .tabItem {
                        Image(systemName: "chair.fill")
                            .font(.title)
                    }
                    .tag(1)
                
                SeatsView()
                    .tabItem {
                        Image(systemName: "message.fill")
                            .font(.title)
                            
                    }
                    .tag(0)
                
                EditProfileView(isEmployee: false)
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.title)
                           
                    }
                    .tag(2)
            }
            .accentColor(accentColor)
            .onAppear {
                if CompanyManager.shared.companyResponses.isEmpty{
                    CompanyManager.shared.fetchUserResponses(){
                        fetchPositions()
                    }
                }else{
                    fetchPositions()
                }
                UITabBar.appearance().unselectedItemTintColor = UIColor(baseColor)
            }
            .environment(\.colorScheme, .light)
        }
    }
    
    func hasAtLeastTwoMatches(positionHardSkills: [String], userHardSkills: [String]) -> Bool {
        let commonSkills = Set(positionHardSkills).intersection(userHardSkills)
        return commonSkills.count >= 1
    }
    
    private func fetchPositions(){
        FirestoreManager.shared.fetchPositions(forCompanyId: CompanyManager.shared.companyName ?? "") { result in
            switch result {
            case .success(let positions):
                for position in positions {
                    let likes = position["likes"] as? [String] ?? []
                    let hardSkills = position["skills"] as? [String] ?? []
                    let positionName = position["position"] as? String ?? "No name"
                    for userUid in likes {
                        FirestoreManager.shared.fetchUser(fromId: userUid) { result in
                            switch result {
                            case .success(let data):
                                print("")
//                                let userResponses = data["responses"] as? [String] ?? []
                                print("data \(data)")
                                EmployeeCard.generateEmplyeeCard(employeeDetails: data, positionName: positionName, employeeUid: userUid) { result in
                                    switch result {
                                    case .success(var employeeCard):
                                        employeeCard.similarity = calculateSimilarity(companyArray: employeeCard.responses, userArray: CompanyManager.shared.companyResponses, positionHardskills: employeeCard.hardSkills, userHardSkills: hardSkills).similarity
                                        self.jobCards.append(employeeCard)
                                    case .failure(let error):
                                        print("Failt to generate employee card \(error)")
                                    }
                                }
                                
                            case .failure(let error):
                                print("Fail to fetch user Data \(error.localizedDescription)")
                            }
                        }
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    

    
    private func calculateSimilarity(companyArray: [String: Int], userArray: [String: Int], positionHardskills: [String], userHardSkills: [String]) -> (similarity: Double, matchingKeys: [String]) {

        let commonKeys = Set(companyArray.keys).intersection(Set(userArray.keys))
        let totalKeys = min(companyArray.count, userArray.count)

        var matches = 0
        var matchingKeys = [String]()

        for key in commonKeys {
            if companyArray[key] == userArray[key] {
                matches += 1
                matchingKeys.append(key)
            }
        }

        let responsesSimilarity = (Double(matches) / Double(totalKeys)) * 100

        // Calculate similarity for positionHardskills vs. userHardSkills
        let commonHardSkills = Set(positionHardskills).intersection(Set(userHardSkills))
        let totalHardSkills = min(positionHardskills.count, userHardSkills.count)

        let hardSkillsSimilarity = (Double(commonHardSkills.count) / Double(totalHardSkills)) * 100

        // Calculate the average similarity score
        let averageSimilarity = (responsesSimilarity + hardSkillsSimilarity) / 2.0

        return (averageSimilarity, matchingKeys)

    }

    
}

#Preview {
    CompanyMainView()
}
