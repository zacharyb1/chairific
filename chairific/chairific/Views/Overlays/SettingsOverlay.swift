//
//  SettingsOverlay.swift
//  chairific
//
//  Created by Jules Morillon on 8.11.2024.
//


import SwiftUI

struct SettingsOverlay: View {
    @Binding var showSettings: Bool
    @State private var showLogoutConfirmation = false
    @State private var showAlert: deleteAlert? = nil
    // TO UPDATE
    @AppStorage("isSignedIn") private var isSignedIn: Bool = true
    @AppStorage("isUserAnswers") private var isUserAnswers: Bool = true
    
    enum deleteAlert: Identifiable {
        case confirmation, finalConfirmation, loginPrompt
        
        var id: Int { hashValue }
    }
    
    var body: some View {
        VStack(spacing: 15) {
            
            HStack {
                Button(action: {
                    showLogoutConfirmation = true
                }) {
                    Text("Log out")
                        .foregroundColor(.orange)
                }
                .alert(isPresented: $showLogoutConfirmation) {
                    Alert(
                        title: Text("Log Out"),
                        message: Text("Are you sure you want to log out?"),
                        primaryButton: .destructive(Text("Log Out")) {
                            AuthManager.shared.signOutUser() { result in
                                switch result {
                                case .success:
                                    // TO UPDATE
                                    isSignedIn = false
                                    isUserAnswers = false
                                case .failure:
                                    break
                                }
                            }
                            showSettings = false
                        },
                        secondaryButton: .cancel()
                    )
                }
                Spacer()
            }
            HStack {
                Button(action: {
                    showAlert = .confirmation
                }) {
                    Text("Delete account")
                        .foregroundColor(.red) // Set the text color to red
                }
                .alert(item: $showAlert) { alert in
                    switch alert {
                    case .confirmation:
                        Alert(
                            title: Text("Delete account"),
                            message: Text("Are you sure you want to delete your account? This action is irreversible."),
                            primaryButton: .destructive(Text("Yes")) {
                                showAlert = .finalConfirmation
                            },
                            secondaryButton: .cancel() // Cancel button does nothing
                        )
                    case .finalConfirmation:
                        Alert(
                            title: Text("Delete account"),
                            message: Text("Are you reaaaaaaaaaallyyyyyyyyyy sure you want to delete your account? Last chance to go back..."),
                            primaryButton: .destructive(Text("Delete my account")) {
                                // AuthManager.shared.deleteUser()
                                showSettings = false
                            },
                            secondaryButton: .cancel() // Cancel button does nothing
                        )
                    case .loginPrompt:
                        Alert(
                            title: Text("Delete account"),
                            message: Text("A fresh connection is required to delete your account. Please log in again and reattempt account deletion."),
                            primaryButton: .destructive(Text("Log out")) {
                                AuthManager.shared.signOutUser() { result in
                                    switch result {
                                    case .success:
                                        // TO UPDATE
                                        isSignedIn = false
                                        isUserAnswers = false
                                    case .failure:
                                        break
                                    }
                                }
                                showSettings = false
                            },
                            secondaryButton: .cancel() // Cancel button does nothing
                        )
                    }
                }
                Spacer()
            }
        }
        .padding()
        .frame(width: 300)
        .font(.system(size: 16, weight: .bold))
        .foregroundColor(backgroundColor)
        .background(baseButtonColor)
    }
}
