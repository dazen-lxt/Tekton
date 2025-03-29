//
//  RideTrackingServiceTests.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 29/03/25.
//

import XCTest
import Combine
import CoreLocation
@testable import Tekton

class RideTrackingServiceTests: XCTestCase {
    var rideTrackingService: RideTrackingService!
    var mockLocationManager: MockLocationManager!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockLocationManager = MockLocationManager()
        rideTrackingService = RideTrackingService(locationManager: mockLocationManager)
    }

    override func tearDown() {
        rideTrackingService = nil
        mockLocationManager = nil
        cancellables = []
        super.tearDown()
    }

    func testRequestAuthorization() {
        rideTrackingService.requestAuthorization()
        XCTAssertEqual(mockLocationManager.authorizationStatus, .authorizedAlways)
    }

    func testStartTracking() {
        let expectation = XCTestExpectation(description: "Receive location update")
        rideTrackingService.locationPublisher
            .sink { location in
                XCTAssertEqual(location.latitude, 37.7749)
                XCTAssertEqual(location.longitude, -122.4194)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        rideTrackingService.startTracking()
        mockLocationManager.requestWhenInUseAuthorization()
        mockLocationManager.startUpdatingLocation()

        wait(for: [expectation], timeout: 1.0)
    }

    func testStopTracking() {
        rideTrackingService.startTracking()
        rideTrackingService.stopTracking()
        XCTAssertFalse(mockLocationManager.allowsBackgroundLocationUpdates)
    }
}
