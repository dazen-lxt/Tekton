//
//  OnBoardingPage.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import Foundation

struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
    
    static let pages: [OnboardingPage] = [
        OnboardingPage(
            title: "Extremely simple to use",
            iconName: "hand.thumbsup.fill"
        ),
        OnboardingPage(
            title: "Track your time and distance",
            iconName: "timer"
        ),
        OnboardingPage(
            title: "See your progress and challenge yourself!",
            iconName: "chart.bar.fill"
        )
    ]
}
