//
//  RidesListView.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import SwiftUI
import CoreLocation

struct RidesListView: View {
    @StateObject var viewModel: RidesListViewModel

    var body: some View {
        NavigationView {
            List(viewModel.rides) { ride in
                HStack(alignment: .center, spacing: 4) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(viewModel.formattedDuration(ride.duration))").font(.title)
                        Text("📍 \(ride.startPoint)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        Text("🏁 \(ride.endPoint)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                    Text("\(viewModel.formattedDistance(ride.distance))").font(.title2)
                }
                .padding(.vertical, 4)
            }
            .onAppear() {
                viewModel.loadRides()
            }
            .navigationTitle("My Progress")
        }
    }
}
