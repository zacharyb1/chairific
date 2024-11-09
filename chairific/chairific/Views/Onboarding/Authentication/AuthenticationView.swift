//
//  AuthenticationView.swift
//  chairific
//
//  Created by Ivan Semeniuk on 08/11/2024.
//

import Foundation
import SwiftUI
import FirebaseAuth
import _AuthenticationServices_SwiftUI
import FirebaseCore

struct AuthenticationView: View {
    
    @State private var email = ""
    @State private var password = ""
    @AppStorage("isSignedIn") private var isSignedIn: Bool = false
    @State private var createAccount = false
    @State private var errorMessage = ""
    @AppStorage("isUserAnswers") private var isUserAnswers: Bool = false
    @AppStorage("isEmployee") private var isEmployee: Bool = false
    @State var navigateToMainScreen = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            ZStack {

                VStack(alignment: .leading, spacing: 20) {
                    Text("Log in")
                        .font(.largeTitle)
                        .foregroundColor(Color.gray.opacity(0.8))
                        .padding(.top)
                        .padding(.bottom, 20)
                    Spacer()
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Email")
                            .font(.headline)
                            .foregroundColor(Color.gray.opacity(0.8))
                            .padding(.bottom, 10)
                        TextField("", text: $email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .autocapitalization(.none)
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
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }

                    HStack {
                        Spacer()
                        Button(action: signIn) {
                            Text("Log In")
                                .padding()
                                .frame(width: 120, height: 50)
                                .background(Color.orange)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    }
                    HStack {
                        Text("Not a user yet?")
                            .foregroundColor(Color.gray.opacity(0.8))
                        
                        Button(action: {
                            createAccount = true
                        }) {
                            Text("Register")
                                .foregroundColor(.blue)
                                .bold()
                        }
                        Spacer()
                    }
                    Spacer()
                    Spacer()
                    
                }
                .padding()
                .padding(.horizontal)

                if isLoading {
                    ZStack {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack(spacing: 20) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .scaleEffect(1.5)
                            Text("Authenticating...")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                    }
                }
                
            }
            .navigationDestination(isPresented: $createAccount) {
                OnboardingView()
            }
            .navigationDestination(isPresented: $navigateToMainScreen) {
                MainView()
            }
            .navigationBarBackButtonHidden()
 
        }
        .environment(\.colorScheme, .light)
    }
    
    private func signIn() {
        isLoading = true
        AuthManager.shared.signInUser(email: email, password: password) { result in
            switch result {
            case .success(let authResult):
                AuthManager.shared.initUser()
                UserManager.shared.usersResponses.removeAll()
                UserManager.shared.fetchUserResponses(){
                    isLoading = false
                }
                
                checkIfIsEmployee(uid: authResult.user.uid) { value in
                    if value{
                        isEmployee = true
                    }else{
                        isEmployee = false
                    }

                    isSignedIn = true
                    isUserAnswers = true
                    navigateToMainScreen = true
                }
            case .failure(let error):
                isLoading = false
                errorMessage = error.localizedDescription
            }
        }
    }
    
    
    private func checkIfIsEmployee(uid: String, completion: @escaping (Bool) -> Void) {
        FirestoreManager.shared.fetchUser(fromId: uid) { result in
            switch result {
            case .success(let _):
                print("Employee")
                completion(true)  // Return true if successful
            case .failure(let error):
                print("Fail to fetch user, user is not employee \(error.localizedDescription)")
                completion(false) // Return false if there’s an error
            }
        }
    }
    
}


#Preview {
    AuthenticationView()
}
