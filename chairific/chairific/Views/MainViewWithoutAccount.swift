//
//  MainViewWithoutAccount.swift
//  chairific
//
//  Created by Ivan Semeniuk on 10/11/2024.
//

import SwiftUI

struct MainViewWithoutAccount: View {
    @State private var selectedTab: Int = 1
    let accentColor: Color = Color.orange
    let baseColor: Color = Color.white
    let tabSize: CGFloat = 30
    @State private var jobCards: [JobCard] = []
    @State private var matchList: [JobCard] = []

    init() {
        UITabBar.appearance().backgroundColor = UIColor.figmaGrey
        UITabBar.appearance().unselectedItemTintColor = UIColor(baseColor)
    }

    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                SwipingView(jobCards: $jobCards)
                    .tabItem {
                        Image(systemName: "chair.fill")
                            .font(.title)
                    }
                    .tag(1)
                
                Text("Create an account to see all information")
                    .tabItem {
                        Image(systemName: "message.fill")
                            .font(.title)
                            
                    }
                    .tag(0)
                
                Text("Create an account to see all information")
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.title)
                           
                    }
                    .tag(2)
            }
            .accentColor(accentColor)
            .onAppear {

                UITabBar.appearance().unselectedItemTintColor = UIColor(baseColor)
            }
        }
        .environment(\.colorScheme, .light)
    }
    

    
}


#Preview {
    MainViewWithoutAccount()
}
