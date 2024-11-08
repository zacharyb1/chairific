//
//  UserManager.swift
//  chairific
//
//  Created by Ivan Semeniuk on 08/11/2024.
//

import Foundation

class UserManager{
    static let shared = UserManager()
    
    private init() {}

    var usersResponses: [String: Int] = [:]
    var hardSkills: [String] = []
    var hobbies: [String] = []
    @Published var userFirstName: String?
    var userSecondName: String?
    
    func reset(){
        usersResponses = [:]
        userFirstName = nil
        userSecondName = nil
    }
    
    func fetchUserResponses(completion: @escaping () -> Void) {

        if self.usersResponses.isEmpty {
            guard let userID = AuthManager.shared.getCurrentUser()?.uid else {
                return
            }
            
            FirestoreManager.shared.fetchUser(fromId: userID) { result in
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
    
}
