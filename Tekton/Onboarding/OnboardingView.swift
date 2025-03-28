//
//  OnboardingView.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var currentPage = 0

    var body: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()

            VStack {
                TabView(selection: $currentPage) {
                    ForEach(OnboardingPage.pages.indices, id: \.self) { index in
                        OnboardingPageView(page: OnboardingPage.pages[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(maxHeight: .infinity)

                HStack(spacing: 8) {
                    ForEach(OnboardingPage.pages.indices, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.white : Color.white.opacity(0.4))
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.bottom, 16)

                Button(action: {
                    if currentPage == OnboardingPage.pages.count - 1 {
                        hasSeenOnboarding = true
                    } else {
                        currentPage += 1
                    }
                }) {
                    Text(currentPage == OnboardingPage.pages.count - 1 ? "Get Started" : "Next")
                        .font(.headline)
                        .foregroundColor(.orange)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 40)
                }
            }
        }
    }
}
