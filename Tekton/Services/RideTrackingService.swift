//
//  RideTrackingService.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 29/03/25.
//

import Foundation
import CoreLocation
import Combine

final class RideTrackingService: NSObject, RideTrackingServiceProtocol {
    private var locationManager: LocationManaging
    private let locationSubject = PassthroughSubject<CLLocationCoordinate2D, Never>()
    private var isTracking = false

    var locationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> {
        return locationSubject.eraseToAnyPublisher()
    }
    
    init(locationManager: LocationManaging = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.pausesLocationUpdatesAutomatically = false
    }

    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }

    func startTracking() {
        isTracking = true

        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            print("Location permission not granted.")
        @unknown default:
            break
        }
    }

    func stopTracking() {
        isTracking = false
        locationManager.stopUpdatingLocation()
    }
}

extension RideTrackingService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard isTracking, let location = locations.last else { return }
        locationSubject.send(location.coordinate)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al obtener la ubicación: \(error.localizedDescription)")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            if isTracking {
                locationManager.startUpdatingLocation()
            }
        case .denied, .restricted:
            print("Location access denied.")
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
}
