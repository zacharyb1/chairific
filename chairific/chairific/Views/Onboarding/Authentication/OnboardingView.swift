//
//  OnboardingView.swift
//  chairific
//
//  Created by Benoit Pennaneach on 8.11.2024.
//

import SwiftUI

struct OnboardingView: View {
    @State private var selectedOption: String?
    
    @State var navigateToMainScreen = false
    @State var isEmployee = false
    @State var isCompany = false
    @State var amazon = false
    
    var body: some View {
        
            ZStack {
                VStack(alignment: .leading) {
                    Text("What brings you here?")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                        .padding(.top, 100)
                    
                    Spacer()
                    
                    // Options
                    VStack(spacing: 20) {
                        RadioButton(text: "Looking for a job", selectedOption: $selectedOption)
                        RadioButton(text: "Looking for employees", selectedOption: $selectedOption)
                        RadioButton(text: "I want a new chair", selectedOption: $selectedOption)
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            if selectedOption == "Looking for a job" {
                                print("YOU ARE AN EMPLOYEE")
                                isEmployee = true
                                isCompany = false
                                amazon = false
                            } else if selectedOption == "Looking for employees"  {
                                isEmployee = false
                                isCompany = true
                                amazon = false
                                print("YOU ARE A COMPANY")
                            } else {
                                amazon = true
                                isEmployee = false
                                isCompany = false
                                openAmazonWebsite()
                                print("AMAZON")
                            }
                        }) {
                            Text("Continue")
                                .font(.system(size: 18, weight: .bold))
                                .frame(width: 200, height: 50)
                                .background(.orange)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .padding(.horizontal)
                                .shadow(radius: 5)
                        }
                        .padding(.bottom, 50)
                        .padding(.trailing, 20)
                    }
                }
                .background(Color(UIColor.systemGray6))
                .ignoresSafeArea()
            }
            .navigationDestination(isPresented: $isEmployee) {
                RegistrationView()
            }
            .navigationDestination(isPresented: $isCompany){
                CompanyRegistrationView()
            }
            
        
    }
    private func openAmazonWebsite() {
        if let url = URL(string: "https://www.amazon.com") {
            UIApplication.shared.open(url)
        }
    }
}

struct RadioButton: View {
    let text: String
    @Binding var selectedOption: String?
    
    var body: some View {
        Button(action: {
            selectedOption = text
        }) {
            HStack {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.gray)
                    .background(Circle().fill(selectedOption == text ? Color.gray : Color.clear))
                    .frame(width: 24, height: 24)
                
                Text(text)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
        }
    }
}

#Preview {
    OnboardingView()
}
