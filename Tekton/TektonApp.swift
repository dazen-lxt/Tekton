//
//  TektonApp.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import SwiftUI

@main
struct TektonApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    var body: some Scene {
        WindowGroup {
            if !hasSeenOnboarding {
                ContentView()
            } else {
                OnboardingView()
            }
        }
    }
}
