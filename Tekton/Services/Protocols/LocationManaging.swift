//
//  LocationManaging.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 29/03/25.
//

import CoreLocation
import Combine

protocol LocationManaging {
    var delegate: CLLocationManagerDelegate? { get set }
    var authorizationStatus: CLAuthorizationStatus { get }
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
    func requestAlwaysAuthorization()
    var allowsBackgroundLocationUpdates: Bool { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }
    var pausesLocationUpdatesAutomatically: Bool { get set }
}

extension CLLocationManager: LocationManaging {}
