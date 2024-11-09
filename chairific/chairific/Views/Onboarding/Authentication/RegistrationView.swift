//
//  RegistrationView.swift
//  chairific
//
//  Created by Ivan Semeniuk on 08/11/2024.
//

import SwiftUI
import FirebaseAuth
import _AuthenticationServices_SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var name = ""
    @State private var surname = ""
    @State private var password = ""
    @State private var isRegistered = false
    @State private var isAddedUser = false
    @State private var isName = false
    @State private var errorMessage = ""
    @State private var repeatPassword = ""
    @AppStorage("isSignedIn") private var isSignedIn: Bool = false
    @State private var isLoading = false

    
    var body: some View {
            ZStack {
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Registration")
                            .font(.largeTitle)
                            .foregroundColor(Color.gray.opacity(0.8))
                            .padding(.bottom, 10)

                        VStack(alignment: .leading, spacing: 2) {
                            VStack(alignment: .leading){
                                Text("Name")
                                    .font(.headline)
                                    .foregroundColor(Color.gray.opacity(0.8))
                                Text("(Potential employers will not see it)")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.gray.opacity(0.8))
                                    .padding(.bottom, 10)
                            }
                            TextField("", text: $name)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            VStack(alignment: .leading){
                                Text("Last name")
                                    .font(.headline)
                                    .foregroundColor(Color.gray.opacity(0.8))
                                Text("(Potential employers will not see it)")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.gray.opacity(0.8))
                                    .padding(.bottom, 10)
                            }
                            TextField("", text: $surname)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            VStack(alignment: .leading){
                                Text("Email")
                                    .font(.headline)
                                    .foregroundColor(Color.gray.opacity(0.8))
                                Text("(Potential employers will not see it)")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color.gray.opacity(0.8))
                                    .padding(.bottom, 10)
                            }
                            TextField("", text: $email)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Password")
                                .font(.headline)
                                .foregroundColor(Color.gray.opacity(0.8))
                                .padding(.bottom, 10)
                            SecureField("", text: $password)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Repeat Password")
                                .font(.headline)
                                .foregroundColor(Color.gray.opacity(0.8))
                                .padding(.bottom, 10)
                            SecureField("", text: $repeatPassword)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        
                        if !errorMessage.isEmpty {
                            Text(errorMessage)
                                .foregroundColor(.red)
                        }
                        
                        HStack {
                            Spacer()
                            Button(action: signUp) {
                                Text("Register")
                                    .padding()
                                    .frame(width: 120, height: 50)
                                    .background(Color.orange)
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                            }
                        }

                        
                    }
                    .padding()
                    .padding(.horizontal)
                    
                    
                    
                }
                if isLoading {
                    ZStack {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack(spacing: 20) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .scaleEffect(1.5)
                            Text("Creating your account...")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    }
                }

            }
            .navigationDestination(isPresented: $isAddedUser) {
                SkillsView()
            }

    }
    
    
    private func signUp() {
        isLoading = true
        if name.isEmpty{
            errorMessage = "Field name is empty"
            isLoading = false
            return
        }
        if surname.isEmpty{
            errorMessage = "Field surname is empty"
            isLoading = false
            return
        }
        if password != repeatPassword {
            errorMessage = "Passwords do not match"
            isLoading = false
            return
        }
        
        AuthManager.shared.registerUser(email: email, password: password) { result in
            switch result {
            case .success(let authResult):
                isRegistered = true
                let currentDate = Date()
                let userData: [String: Any] = [
                    "name": name,
                    "surname": surname,
                ]
                FirestoreManager.shared.addUser(uid: authResult.user.uid, data: userData) { firestoreResult in
                    switch firestoreResult {
                    case .success():
                        AuthManager.shared.initUser()
                        UserManager.shared.usersResponses.removeAll()
                        isSignedIn = true
                        isAddedUser = true
                        isLoading = false
                        UserManager.shared.userFirstName = name
                        UserManager.shared.userSecondName = surname
                        print("Successfully added User")
                    case .failure(let firestoreError):
                        isLoading = false
                        print("Errod while adding user \(firestoreError.localizedDescription)")
                        errorMessage = firestoreError.localizedDescription
                    }
                }
            case .failure(let error):
                isLoading = false
                errorMessage = error.localizedDescription
            }
        }
    }
}


#Preview {
    RegistrationView()
}




