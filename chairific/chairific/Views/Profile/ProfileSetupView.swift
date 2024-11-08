//
//  ProfileSetupView.swift
//  chairific
//
//  Created by Benoit Pennaneach on 8.11.2024.
//

import SwiftUI
struct ProfileSetupView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var industry = ""
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Profile Setup")
                    .font(.system(size: 34, weight: .semibold))
                    .padding(.leading, 20)
                    .padding(.top)
                    .foregroundStyle(.gray)
                Spacer()
            }
            .padding(.top, 50)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading){
                    Text("Name")
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.leading, 20)
                        .foregroundStyle(.gray)
                    
                    TextField("", text: $firstName)
                        .padding()
                        .frame(height: 50)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                VStack(alignment: .leading){
                    Text("Last name")
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.leading, 20)
                        .foregroundStyle(.gray)
                    TextField("", text: $lastName)
                        .padding()
                        .frame(height: 50)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                VStack(alignment: .leading){
                    Text("Industry")
                        .font(.system(size: 24, weight: .semibold))
                        .padding(.leading, 20)
                        .foregroundStyle(.gray)
                    TextField("", text: $industry)
                        .padding()
                        .frame(height: 50)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                
            }
                .padding()
            Spacer()
            
            
            HStack {
                Spacer()
                Button(action: {
                    
                }) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .bold))
                        .frame(width: 200, height: 50)
                        .background(Color.orange)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .padding(.trailing, 20)
                        .shadow(radius: 5)
                }
            }
            .padding(.bottom, 50)
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.all)
    }
}
#Preview {
    ProfileSetupView()
}
