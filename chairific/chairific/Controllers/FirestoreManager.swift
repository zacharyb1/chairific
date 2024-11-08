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
    
    func fetchCompany(fromId: String, completion: @escaping (Result<Dictionary<String, Any>, Error>) -> Void) {
        db.collection("companies").document(fromId).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                completion(.success(document.data() ?? [:]))
            } else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Event not found"])
                completion(.failure(error))
            }
        }
    }
    
}
