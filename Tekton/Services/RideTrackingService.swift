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
    private let locationManager = CLLocationManager()
    private let locationSubject = PassthroughSubject<CLLocationCoordinate2D, Never>()
    private var isTracking = false

    var locationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> {
        return locationSubject.eraseToAnyPublisher()
    }

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }

    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }

    func startTracking() {
        guard CLLocationManager.locationServicesEnabled() else {
            print("Los servicios de ubicación no están habilitados.")
            return
        }
        isTracking = true
        locationManager.startUpdatingLocation()
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
        case .authorizedAlways, .authorizedWhenInUse:
            print("Permiso concedido.")
        case .denied, .restricted:
            print("Permiso denegado o restringido.")
        case .notDetermined:
            print("Permiso no determinado.")
        @unknown default:
            print("Estado de autorización desconocido.")
        }
    }
}
