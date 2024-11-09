//
//  MainView.swift
//  chairific
//
//  Created by Jules Morillon on 8.11.2024.
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    @State private var selectedTab: Int = 1
    let accentColor: Color = Color.orange
    let baseColor: Color = Color.white
    let tabSize: CGFloat = 30
    @State private var jobCards: [JobCard] = []

    init() {
        UITabBar.appearance().backgroundColor = UIColor.figmaGrey
        UITabBar.appearance().unselectedItemTintColor = UIColor(baseColor)
    }

    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                SwipingView(jobCards: $jobCards)
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
                
                EditProfileView(isEmployee: true)
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.title)
                           
                    }
                    .tag(2)
            }
            .accentColor(accentColor)
            .onAppear {
                if UserManager.shared.usersResponses.isEmpty{
                    UserManager.shared.fetchUserResponses(){
                        fetchPositions()
                    }
                }else{
                    fetchPositions()
                }
                UITabBar.appearance().unselectedItemTintColor = UIColor(baseColor)
            }
        }
        .environment(\.colorScheme, .light)
    }
    
    func hasAtLeastTwoMatches(positionHardSkills: [String], userHardSkills: [String]) -> Bool {
        let commonSkills = Set(positionHardSkills).intersection(userHardSkills)
        return commonSkills.count >= 1
    }
    
    private func fetchPositions(){
        guard currentUserId != "" else {
            return
        }
        
        
        FirestoreManager.shared.fetchAllPositions { result in
            switch result {
            case .success(let positions):
                for position in positions {
                    let positionHardSkills = position["skills"] as? [String] ?? []
                    let likesOnThePosition = position["likes"] as? [String] ?? []
                    let showJobCard = hasAtLeastTwoMatches(positionHardSkills: positionHardSkills, userHardSkills: UserManager.shared.hardSkills)
                    if showJobCard && !likesOnThePosition.contains(currentUserId){
                        JobCard.generateJobCard(position: position) { result in
                            switch result {
                            case .success(var jobcard):
                                jobcard.similarity = calculateSimilarity(companyArray: jobcard.responses, userArray: UserManager.shared.usersResponses, positionHardskills: positionHardSkills, userHardSkills: UserManager.shared.hardSkills).similarity
                                
                                var responses  = calculateSimilarity(companyArray: jobcard.responses, userArray: UserManager.shared.usersResponses, positionHardskills: positionHardSkills, userHardSkills: UserManager.shared.hardSkills).matchingKeys
                                self.jobCards.append(jobcard)
                                print("responses: \(jobcard.responses)")
                            case .failure(let error):
                                print(error)
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
