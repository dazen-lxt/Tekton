//
//  RideStorageTests.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 29/03/25.
//

import XCTest
import CoreData
@testable import Tekton

final class RideStorageTests: XCTestCase {
    
    var storage: RideStorage!
    var context: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        let coreDataStack = CoreDataStack(inMemory: true)
        context = coreDataStack.context
        storage = RideStorage(context: context)
    }

    override func tearDown() {
        storage = nil
        context = nil
        super.tearDown()
    }

    func testSaveRide_persistsRideCorrectly() {
        let startDate = Date()
        let duration = 120.0
        let distance = 3.5
        let startPoint = "Start Address"
        let endPoint = "End Address"

        storage.saveRide(
            startDate: startDate,
            duration: duration,
            distance: distance,
            startPoint: startPoint,
            endPoint: endPoint
        )
        
        let results = storage.fetchAllRides()
        XCTAssertEqual(results.count, 1)

        let ride = results.first!
        XCTAssertEqual(ride.startDate, startDate)
        XCTAssertEqual(ride.duration, duration)
        XCTAssertEqual(ride.distance, distance)
        XCTAssertEqual(ride.startPoint, startPoint)
        XCTAssertEqual(ride.endPoint, endPoint)
    }

    func testFetchAllRides_emptyAtStart() {
        let rides = storage.fetchAllRides()
        XCTAssertTrue(rides.isEmpty)
    }
}
