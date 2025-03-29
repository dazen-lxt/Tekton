//
//  RidesListViewModel.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import CoreData
import Combine
import CoreLocation

final class RidesListViewModel: ObservableObject {
    @Published var rides: [Ride] = []

    private let storage: RideStorageProtocol

    init(storage: RideStorageProtocol) {
        self.storage = storage
    }

    func loadRides() {
        let entities = storage.fetchAllRides()
        rides = entities.map {
            Ride(
                id: $0.id ?? UUID().uuidString,
                date: $0.startDate ?? Date(),
                duration: $0.duration,
                distance: $0.distance,
                startPoint: $0.startPoint ?? "",
                endPoint: $0.endPoint ?? ""
            )
        }
    }

    func formattedDistance(_ distance: Double) -> String {
        String(format: "%.2f km", distance / 1000)
    }

    func formattedDuration(_ duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: duration) ?? "00:00:00"
    }
}
