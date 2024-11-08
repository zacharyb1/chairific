//
//  AuthenticationView.swift
//  chairific
//
//  Created by Jules Morillon on 8.11.2024.
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
    @State var navigateToMainScreen = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
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
//                            .textInputAutocapitalization(.never)
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
                            .padding(.horizontal)
                    }
                    HStack {
                        Spacer() // Push the button to the right
//                        Button("Log In") {
//                            signIn()
//                        }
//                        .padding()
//                        .frame(width: 120, height: 50)
//                        .background(Color.orange)
//                        .foregroundColor(.black)
//                        .cornerRadius(10)
//                        
                        Button(action: signIn) {
                            Text("Log In")
                                .padding()
                                .frame(width: 120, height: 50)
                                .background(Color.orange)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 30)
//                                .stroke(Color.white, lineWidth: 1)
//                        )
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
                    .padding(.top, 10)
                    
                }
                .padding()
                .padding(.horizontal)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Log in")
                        .font(.largeTitle)
                        .foregroundColor(Color.gray.opacity(0.8)) // Adjust color to a lighter gray
                        .padding(.top, 45) // Add padding to move it down
                }
            }
            
            .navigationDestination(isPresented: $createAccount) {
                RegistrationView()
            }
            .navigationDestination(isPresented: $navigateToMainScreen) {
                MainView()
            }
        }
        .environment(\.colorScheme, .light)
    }
    
    private func signIn() {
        AuthManager.shared.signInUser(email: email, password: password) { result in
            switch result {
            case .success(let authResult):
                isSignedIn = true
                isUserAnswers = true
                navigateToMainScreen = true
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
    
    
}
#Preview {
    AuthenticationView()
}
