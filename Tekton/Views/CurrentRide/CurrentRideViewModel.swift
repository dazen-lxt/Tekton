//
//  CurrentRideViewModel.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import Foundation
import CoreLocation
import Combine

final class CurrentRideViewModel: ObservableObject {
    @Published var isTracking: Bool = false
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var route: [CLLocationCoordinate2D] = [] {
        didSet {
            calculateTotalDistance()
        }
    }
    @Published var timerString: String = "00:00:00"
    @Published var hasRideEnded: Bool = false
    @Published var showSaveConfirmation = false
    @Published var isLoading = false
    
    private var totalDistance: Double = 0
    private var rideService: RideTrackingServiceProtocol
    private var rideStorage: RideStorageProtocol
    private var cancellables = Set<AnyCancellable>()
    private var timer: Timer?
    private var secondsElapsed = 0
    private var startDate = Date()
    
    var formattedDistance: String {
        if totalDistance >= 1000 {
            let km = totalDistance / 1000
            return String(format: "%.1f km", km)
        } else {
            return String(format: "%.0f m", totalDistance)
        }
    }
    
    init(rideService: RideTrackingServiceProtocol = MockRideTrackingService(), rideStorage: RideStorageProtocol) {
        self.rideService = rideService
        self.rideStorage = rideStorage
        bindLocation()
    }
    
    func startTracking() {
        isTracking = true
        secondsElapsed = 0
        startDate = Date()
        startTimer()
        rideService.startTracking()
    }

    func stopTracking() {
        stopTimer()
        rideService.stopTracking()
        isTracking = false
        hasRideEnded = true
    }
    
    @MainActor
    func storeRide() async {
        self.isLoading = true
        if route.count > 0 {
            let startAddress = await getAddress(from: route.first!) ?? "Unknown"
            let endAddress = await getAddress(from: route.last!) ?? "Unknown"
            rideStorage.saveRide(startDate: startDate, duration: Double(secondsElapsed), distance: totalDistance, startPoint: startAddress, endPoint: endAddress)
        }
        self.showSaveConfirmation = true
        self.isLoading = false
        endRide()
    }

    @MainActor
    func endRide() {
        hasRideEnded = false
        timerString = "00:00:00"
        totalDistance = 0
        route = []
    }
    
    private func getAddress(from coordinate: CLLocationCoordinate2D) async -> String? {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        return await withCheckedContinuation { continuation in
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let placemark = placemarks?.first {
                    let name = placemark.name ?? ""
                    let city = placemark.locality ?? ""
                    let country = placemark.country ?? ""
                    let address = [name, city, country].filter { !$0.isEmpty }.joined(separator: ", ")
                    continuation.resume(returning: address)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }

    private func bindLocation() {
        rideService.locationPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] coord in
                guard let self = self else { return }
                self.currentLocation = coord
                if self.isTracking {
                    self.route.append(coord)
                }
            }
            .store(in: &cancellables)
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.secondsElapsed += 1
            self.timerString = self.formatTime(self.secondsElapsed)
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func formatTime(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func calculateTotalDistance() {
        guard route.count > 1 else { return }
        var distance: Double = 0
        for i in 1..<route.count {
            let start = CLLocation(latitude: route[i-1].latitude, longitude: route[i-1].longitude)
            let end = CLLocation(latitude: route[i].latitude, longitude: route[i].longitude)
            distance += start.distance(from: end)
        }
        totalDistance = distance
    }
}
