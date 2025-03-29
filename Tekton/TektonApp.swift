//
//  TektonApp.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import GoogleMaps
import SwiftUI

@main
struct TektonApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    private let container = AppContainer()
    init() {
        GMSServices.provideAPIKey("AIzaSyDb_qgq7Pj_IQcYWnbiMAaW_KvBaKZ0PX4")
    }
    
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                MainTabView(container: container)
            } else {
                OnboardingView()
            }
        }
    }
}
