//
//  OnBoardingPageView.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()
                
                Image(systemName: page.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.white)
                    .padding(.bottom, 16)
                
                Text(page.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Spacer()
            }
            .padding()
        }
    }
}
