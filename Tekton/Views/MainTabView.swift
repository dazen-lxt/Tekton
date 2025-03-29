//
//  MainTabView.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import SwiftUI

struct MainTabView: View {
    private let container: AppContainer

    init(container: AppContainer) {
        self.container = container
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.orange
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.normal.iconColor = .white.withAlphaComponent(0.7)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white.withAlphaComponent(0.7)]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            container.makeCurrentRideView()
                .tabItem {
                    Label("Current Ride", systemImage: "bicycle")
                }

            container.makeRidesListView()
                .tabItem {
                    Label("My Progress", systemImage: "clock.arrow.circlepath")
                }
        }.tint(.orange)
    }
}
