//
//  CompanyRegistrationView.swift
//  chairific
//
//  Created by Benoit Pennaneach on 8.11.2024.
//

import SwiftUI
import FirebaseAuth
import _AuthenticationServices_SwiftUI

struct CompanyRegistrationView: View {
    
    @State private var email = ""
    @State private var companyname = ""
    @State private var industry = ""
    @State private var password = ""
    @State private var isRegistered = false
    @State private var isAddedCompany = false
    @State private var isName = false
    @State private var errorMessage = ""
    @State private var repeatPassword = ""
    @AppStorage("isSignedIn") private var isSignedIn: Bool = false
    @State private var isLoading = false

    
    var body: some View {
            ZStack (alignment: .bottomTrailing){
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Registration")
                            .font(.largeTitle)
                            .foregroundColor(Color.gray.opacity(0.8))
                            .padding(.bottom, 10)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Company name")
                                .font(.headline)
                                .foregroundColor(Color.gray.opacity(0.8))
                                .padding(.bottom, 10)
                            TextField("", text: $companyname)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Industry")
                                .font(.headline)
                                .foregroundColor(Color.gray.opacity(0.8))
                                .padding(.bottom, 10)
                            TextField("", text: $industry)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Email")
                                .font(.headline)
                                .foregroundColor(Color.gray.opacity(0.8))
                                .padding(.bottom, 10)
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
                    }
                    .padding()
                    .padding(.horizontal)
                }
                VStack(){
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: signUp) {
                            Text("Continue")
                                .padding()
                                .frame(width: 200, height: 50)
                                .background(Color.orange)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
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
            .navigationDestination(isPresented: $isAddedCompany) {
                CultureView()
            }
    }
    
    private func signUp() {
        isLoading = true
        if email.isEmpty{
            errorMessage = "Email is empty"
            isLoading = false
            return
        }
        if companyname.isEmpty{
            errorMessage = "Company name is empty"
            isLoading = false
            return
        }
        if industry.isEmpty{
            errorMessage = "Industry is empty"
            isLoading = false
            return
        }
        if password.isEmpty{
            errorMessage = "Password is empty"
            isLoading = false
            return
        }
        if repeatPassword != password {
            errorMessage = "Passwords do not match"
            isLoading = false
            return
        }
        
        AuthManager.shared.registerUser(email: email, password: password) { result in
            switch result {
            case .success(let authResult):
                isRegistered = true
                let companyData: [String: Any] = [
                    "id": companyname,
                    "uid": authResult.user.uid,
                    "industry": industry,
                ]
                FirestoreManager.shared.addCompany(id: companyname, data: companyData) { firestoreResult in
                    switch firestoreResult {
                    case .success():
                        CompanyManager.shared.companyResponses.removeAll()
                        isSignedIn = true
                        isAddedCompany = true
                        isLoading = false
                        CompanyManager.shared.companyName = companyname
                        CompanyManager.shared.companyIndustry = industry
                        print("Successfully added Company")
                    case .failure(let firestoreError):
                        isLoading = false
                        print("Errod while adding company \(firestoreError.localizedDescription)")
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
    CompanyRegistrationView()
}




