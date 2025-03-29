//
//  MockLocationManager.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 29/03/25.
//

import CoreLocation
@testable import Tekton

class MockLocationManager: LocationManaging {
    
    var delegate: CLLocationManagerDelegate?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var allowsBackgroundLocationUpdates: Bool = false
    var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyBest
    var pausesLocationUpdatesAutomatically: Bool = false

    func requestWhenInUseAuthorization() {
        authorizationStatus = .authorizedWhenInUse
        delegate?.locationManagerDidChangeAuthorization?(CLLocationManager())
    }
    
    func requestAlwaysAuthorization() {
        authorizationStatus = .authorizedAlways
    }

    func startUpdatingLocation() {
        let mockLocation = CLLocation(latitude: 37.7749, longitude: -122.4194)
        delegate?.locationManager?(CLLocationManager(), didUpdateLocations: [mockLocation])
        allowsBackgroundLocationUpdates = false
    }

    func stopUpdatingLocation() {
        allowsBackgroundLocationUpdates = false
    }
}
