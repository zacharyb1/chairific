//
//  FirestoreManager.swift
//  chairific
//
//  Created by Ivan Semeniuk on 08/11/2024.
//

import FirebaseFirestore
import FirebaseCore

class FirestoreManager {
    static let shared = FirestoreManager()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    // MARK: USER MANAGEMENT
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
    
    func fetchUser(fromId: String, completion: @escaping (Result<Dictionary<String, Any>, Error>) -> Void) {
        db.collection("users").document(fromId).getDocument { document, error in
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
    
    func updateUser(fromId: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(fromId).updateData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func removeUser(fromId: String, completion: @escaping (Result<Void, Error>) -> Void) {
    }
    
    // MARK: COMPANY MANAGEMENT
    func addCompany(uid: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
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
    
    func updateCompany(fromId: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("companies").document(fromId).updateData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func removeCompany(fromId: String, completion: @escaping (Result<Void, Error>) -> Void) {
    }
    
    // MARK: POSITION MANAGEMENT
    func addPosition(uid: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
    }
    
    func fetchPosition(fromId: String, completion: @escaping (Result<Dictionary<String, Any>, Error>) -> Void) {
        db.collection("positions").document(fromId).getDocument { document, error in
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
    
    func updatePosition(fromId: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("positions").document(fromId).updateData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func removePosition(fromId: String, completion: @escaping (Result<Void, Error>) -> Void) {
    }
    
    
    func uploadCollectedAnswers(collectedAnswers: [(questionID: String, answerIndex: Int)], completion: @escaping (Error?) -> Void) {
        guard let userID = AuthManager.shared.getCurrentUser()?.uid else {
            
            return
        }
        
        let answersDictionary = collectedAnswers.reduce(into: [String: Int]()) { result, answer in
            result[answer.questionID] = answer.answerIndex
        }


        let userRef = db.collection("users").document(userID)

        userRef.setData(["responses": answersDictionary], merge: true) { error in
            if let error = error {
                print("Error uploading responses: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Responses successfully uploaded")
                completion(nil)
            }
        }
    }

    func fetchAllPositions(completion: @escaping (Result<[Dictionary<String, Any>], Error>) -> Void) {
        var documents: [Dictionary<String, Any>] = []
        db.collection("positions").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                for document in snapshot.documents {
                    documents.append(document.data())
                }
                completion(.success(documents))
            } else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No positions found"])
                completion(.failure(error))
            }
        }
    }
}
