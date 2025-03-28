//
//  RideTrackingServiceProtocol.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import CoreLocation
import Combine

protocol RideTrackingServiceProtocol {
    var locationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> { get }
    func startTracking()
    func stopTracking()
}
