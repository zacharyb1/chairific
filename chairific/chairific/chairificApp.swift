//
//  chairificApp.swift
//  chairific
//
//  Created by Ivan Semeniuk on 08/11/2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
import Firebase

let backgroundColor: Color = Color(.systemGray5)
let baseButtonColor: Color = Color(.systemGray2)

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.debug)
        return true
    }
}


@main
struct chairificApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
