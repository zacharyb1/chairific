//
//  UserManager 2.swift
//  chairific
//
//  Created by Jules Morillon on 9.11.2024.
//


import Foundation

class CompanyManager: ObservableObject {
    static let shared = CompanyManager()
    
    private init() {}

    var companyResponses: [String: Int] = [:]
    var benefits: [String] = []
    var culture: [String] = []
    @Published var companyName: String?
    @Published var companyIndustry: String?
    
    func reset(){
        companyResponses = [:]
        companyName = nil
        companyIndustry = nil
    }
    
    func fetchUserResponses(completion: @escaping () -> Void) {
        guard let currentUserId = AuthManager.shared.getCurrentUser()?.uid  else {
            return
        }
     
        if self.companyResponses.isEmpty {
            FirestoreManager.shared.fetchCompanies(withUid: currentUserId) { result in
                switch result {
                case .success(let data):
                    if let responses = data["responses"] as? [String: Int] {
                        self.companyResponses = responses
                        print("user resp: \(self.companyResponses)")
                    } else {
                        print("No responses field found in user data")
                    }
                    
                    if let responses = data["culture"] as? [String] {
                        self.culture = responses
                    } else {
                        print("No skills field found in user data")
                    }
                    
                    if let responses = data["benefits"] as? [String] {
                        self.benefits = responses
                    } else {
                        print("No hobbies field found in user data")
                    }
                    
                    if let name = data["id"] as? String, let industry = data["industry"] as? String {
                        self.companyName = name
                        self.companyIndustry = industry
                        print("user name: \(self.companyName), user industry: \(self.companyIndustry)")
                    } else {
                        print("No name or industry field found in company data")
                    }
                    completion()
                case .failure(let error):
                    print("Failed to fetch user data: \(error.localizedDescription)")
                    completion()
                }
            }
        }
        else{
            completion()
        }
    }
    
    func likePosition(_ position: [String: Any], userUid: String) {

        var updatedLikes: [String] = position["matchedUsers"] as? [String] ?? []
        updatedLikes.append(userUid)
        FirestoreManager.shared.updatePosition(fromId: position["id"] as? String ?? "", data: ["matchedUsers":updatedLikes]) { result in
            switch result {
            case .success:
                print("Successfully liked position")
            case .failure:
                print("Error liking position")
            }
        }
    }
    
    func uploadCollectedAnswers(collectedAnswers: [(questionID: String, answerIndex: Int)]) {
        guard let id = companyName else {
            return
        }
        
        let answersDictionary = collectedAnswers.reduce(into: [String: Int]()) { result, answer in
            result[answer.questionID] = answer.answerIndex
        }

        FirestoreManager.shared.updateCompany(fromId: id, data: ["responses": answersDictionary]) { result in
            switch result {
            case .success:
                print("Responses successfully uploaded")
            case .failure(let error):
                print("Error uploading responses: \(error.localizedDescription)")
            }
        }
    }
}
