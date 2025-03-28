//
//  MockRideTrackingService.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import Foundation
import Combine
import CoreLocation

final class MockRideTrackingService: RideTrackingServiceProtocol {
    private let subject = PassthroughSubject<CLLocationCoordinate2D, Never>()
    private var timer: Timer?
    private var currentLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // San Francisco
    private var cancellables = Set<AnyCancellable>()

    var locationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> {
        subject.eraseToAnyPublisher()
    }

    func startTracking() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.currentLocation = self.randomNearbyCoordinate(from: self.currentLocation)
            self.subject.send(self.currentLocation)
        }
    }

    func stopTracking() {
        timer?.invalidate()
        timer = nil
    }

    private func randomNearbyCoordinate(from coordinate: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let maxOffset = 0.0003
        let latOffset = Double.random(in: -maxOffset...maxOffset)
        let lonOffset = Double.random(in: -maxOffset...maxOffset)

        return CLLocationCoordinate2D(
            latitude: coordinate.latitude + latOffset,
            longitude: coordinate.longitude + lonOffset
        )
    }
}
