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
        
        let userDocument = db.collection("users").document(uid)
        
        // Check if the document exists
        userDocument.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if document?.exists == true {
                // If the document exists, update only specific fields
                userDocument.updateData(updatedData) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            } else {
                // If the document doesn't exist, create it with setData
                userDocument.setData(updatedData, merge: true) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
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
    func addCompany(id: String, data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        var updatedData = data
        updatedData["timestamp"] = Timestamp(date: Date())
        
        let userDocument = db.collection("companies").document(id)
        
        // Check if the document exists
        userDocument.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if document?.exists == true {
                // If the document exists, update only specific fields
                userDocument.updateData(updatedData) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
            } else {
                // If the document doesn't exist, create it with setData
                userDocument.setData(updatedData) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(()))
                    }
                }
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
    func addPosition(data: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        let userDocument = db.collection("positions").addDocument(data: data)
        userDocument.updateData(["id": userDocument.documentID]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
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
