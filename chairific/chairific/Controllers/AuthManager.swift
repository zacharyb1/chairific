//
//  AuthManager.swift
//  chairific
//
//  Created by Ivan Semeniuk on 08/11/2024.
//

import Foundation
import FirebaseAuth

class AuthManager{
    static let shared = AuthManager()
    
    private init() {}
    
    func initUser() {
        if let currentUser = Auth.auth().currentUser {
            currentUserId = currentUser.uid
        }
    }
    
    func deleteAccount() async throws{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        try await user.delete()
    }
    
    func signOutUser(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let signOutError as NSError {
            completion(.failure(signOutError))
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
    func signInUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
}
