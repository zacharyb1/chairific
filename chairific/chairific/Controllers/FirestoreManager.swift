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
    
    func fetchCompanies(withUid uid: String, completion: @escaping (Result<Dictionary<String, Any>, Error>) -> Void) {
        db.collection("companies").whereField("uid", isEqualTo: uid).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot, !snapshot.isEmpty {
                // Assuming we only need the first matching document
                if let document = snapshot.documents.first {
                    completion(.success(document.data()))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])
                    completion(.failure(error))
                }
            } else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])
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
    


    
    
    func uploadCollectedAnswers(collectedAnswers: [(questionID: String, answerIndex: Int)], completion: @escaping (Error?) -> Void) {
        guard currentUserId != "" else {
            return
        }
        
        let answersDictionary = collectedAnswers.reduce(into: [String: Int]()) { result, answer in
            result[answer.questionID] = answer.answerIndex
        }

        let userRef = db.collection("users").document(currentUserId)

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
    
    
    func fetchPositions(forCompanyId companyId: String, completion: @escaping (Result<[Dictionary<String, Any>], Error>) -> Void) {
        db.collection("positions").whereField("companyId", isEqualTo: companyId).getDocuments { snapshot, error in
            var documents: [Dictionary<String, Any>] = []
            
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                for document in snapshot.documents {
                    documents.append(document.data())
                }
                completion(.success(documents))
            } else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No positions found for the specified companyId"])
                completion(.failure(error))
            }
        }
    }

    func fetchMatches(forCompanyId companyId: String, completion: @escaping (Result<[Dictionary<String, Any>], Error>) -> Void) {
        var matchedUsers: [Dictionary<String, Any>] = []
        
        fetchPositions(forCompanyId: companyId) { result in
            switch result {
            case .success(let documents):
                for position in documents {
                    let matchedUserIds: [String] = position["matchedUsers"] as? [String] ?? []
                    
                    for userId in matchedUserIds {
                        self.fetchUser(fromId: userId) { result in
                            switch result {
                            case .success(let user):
                                matchedUsers.append(user)
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }
                    }
                }
                completion(.success(matchedUsers))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMatches(completion: @escaping (Result<[Dictionary<String, Any>], Error>) -> Void) {
        guard currentUserId != "" else {
            return
        }
        
        var matchedPositions: [Dictionary<String, Any>] = []
        
        fetchAllPositions { result in
            switch result {
            case .success(let documents):
                for position in documents {
                    let matchedUserIds: [String] = position["matchedUsers"] as? [String] ?? []
                    
                    if matchedUserIds.contains(where: { $0 == currentUserId }) {
                        matchedPositions.append(position)
                    }
                }
                completion(.success(matchedPositions))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
