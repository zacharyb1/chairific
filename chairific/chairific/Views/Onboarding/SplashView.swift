//
//  SplashView.swift
//  chairific
//
//  Created by Jules Morillon on 8.11.2024.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    @State var existingAccount: Bool = false
    let accentColor: Color = Color(red: 0.6, green: 0.3, blue: 0.25)
    var body: some View {
        VStack(spacing: 100) {
            Image("mainchair")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(40)
                .background(Circle().fill(.white))
                .foregroundStyle(accentColor)
            
            Text("Chair-ific")
                .font(.system(size: 48, weight: .semibold))
                .foregroundStyle(.white)
            
            Button { isActive = true } label: {
                    Text("Get started")
                        .font(.system(size: 36, weight: .light))
                        .foregroundStyle(.black)
                        .padding()
                        .background(.yellow)
                        .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.orange)
        .fullScreenCover(isPresented: $isActive) {
            if existingAccount {
                MainView()
            } else {
                EntryQuestionnaireView()
                    .onDisappear() {
                        existingAccount = true
                        isActive = true
                    }
            }
        }
    }
}

#Preview {
    SplashView()
}
