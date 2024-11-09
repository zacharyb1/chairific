//
//  UserManager.swift
//  chairific
//
//  Created by Ivan Semeniuk on 08/11/2024.
//

import Foundation

class UserManager: ObservableObject {
    static let shared = UserManager()
    
    private init() {}

    @Published var usersResponses: [String: Int] = [:]
    var hardSkills: [String] = []
    var hobbies: [String] = []
    @Published var userFirstName: String?
    @Published var userSecondName: String?
    
    func reset(){
        usersResponses = [:]
        userFirstName = nil
        userSecondName = nil
        hardSkills = []
        hobbies = []
    }
    
    
    func fetchUserResponses(completion: @escaping () -> Void) {
        guard currentUserId != "" else {
            return
        }
        
        if self.usersResponses.isEmpty {
            FirestoreManager.shared.fetchUser(fromId: currentUserId) { result in
                switch result {
                case .success(let data):
                    if let responses = data["responses"] as? [String: Int] {
                        self.usersResponses = responses
                        print("user resp: \(self.usersResponses)")
                    } else {
                        print("No responses field found in user data")
                    }
                    
                    if let responses = data["skills"] as? [String] {
                        self.hardSkills = responses
                    } else {
                        print("No skills field found in user data")
                    }
                    
                    if let responses = data["hobbies"] as? [String] {
                        self.hobbies = responses
                    } else {
                        print("No hobbies field found in user data")
                    }
                    
                    if let name = data["name"] as? String, let surname = data["surname"] as? String {
                        self.userFirstName = name
                        self.userSecondName = surname
                        print("user name: \(self.userFirstName), user surname: \(self.userSecondName)")
                    } else {
                        print("No name or surname field found in user data")
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
    
    func likePosition(_ position: Dictionary<String, Any>) {
        guard currentUserId != "" else {
            return
        }
        var updatedLikes: [String] = position["likes"] as? [String] ?? []
        updatedLikes.append(currentUserId)
        FirestoreManager.shared.updatePosition(fromId: position["id"] as? String ?? "", data: ["likes":updatedLikes]) { result in
            switch result {
            case .success:
                print("Successfully liked position")
            case .failure:
                print("Error liking position")
            }
        }
    }
    
    func uploadCollectedAnswers(collectedAnswers: [(questionID: String, answerIndex: Int)]) {
        guard currentUserId != "" else {
            return
        }
        
        let answersDictionary = collectedAnswers.reduce(into: [String: Int]()) { result, answer in
            result[answer.questionID] = answer.answerIndex
        }

        FirestoreManager.shared.updateUser(fromId: currentUserId, data:["responses": answersDictionary]) { result in
            switch result {
            case .success:
                print("Responses successfully uploaded")
            case .failure(let error):
                print("Error uploading responses: \(error.localizedDescription)")
            }
        }
    }
}
