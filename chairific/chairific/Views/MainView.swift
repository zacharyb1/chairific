//
//  MainView.swift
//  chairific
//
//  Created by Jules Morillon on 8.11.2024.
//


import SwiftUI
struct MainView: View {
    @State private var selectedTab: Int = 1
    
    private let backgroundColor = Color(.systemGray5)
    private let baseColor = Color(.systemGray2)
    private let accentColor = Color(red: 0.6, green: 0.3, blue: 0.25)
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // Action for notifications
                }) {
                    Image(systemName: "bell.fill")
                        .font(.title2)
                        .padding()
                        .foregroundStyle(baseColor)
                }
                
                Spacer()
                
                Image(systemName: "chair.lounge.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(accentColor)
                
                Spacer()
                
                Button(action: {
                    // Action for settings
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.title2)
                        .padding()
                        .foregroundStyle(baseColor)
                }
            }
            .padding(.horizontal)
            .background(backgroundColor)
            
            Spacer()
            
            // Main Content
            TabView(selection: $selectedTab) {
                Text("View 1")
                    .tabItem {
                        Image(systemName: "square.grid.2x2")
                        Text("Temporary")
                    }
                    .tag(0)
                
                Text("Swiping View")
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(1)
                
                Text("Profile View")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(2)
            }
            .accentColor(accentColor)
        }
    }
}
#Preview {
    MainView()
}
