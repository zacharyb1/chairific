//
//  FirestoreManager.swift
//  chairific
//
//  Created by Ivan Semeniuk on 08/11/2024.
//

import Foundation
import FirebaseFirestore

class FirestoreManager{
    static let shared = FirestoreManager()
    
    
    private init() {}
    
    private let db = Firestore.firestore()
    
    func addUser(uid: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        var updatedData = data
        updatedData["timestamp"] = Timestamp(date: Date())
        db.collection("users").document(uid).setData(updatedData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
}
