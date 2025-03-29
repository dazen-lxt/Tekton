//
//  RideStorage.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import CoreData
import CoreLocation

final class RideStorage: RideStorageProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func saveRide(
        startDate: Date,
        duration: Double,
        distance: Double,
        startPoint: String,
        endPoint: String
    ) {
        let ride = RideEntity(context: context)
        ride.id = UUID().uuidString
        ride.startDate = startDate
        ride.duration = duration
        ride.distance = distance
        ride.startPoint = startPoint
        ride.endPoint = endPoint
        
        do {
            try context.save()
            print("✅ Ride saved")
        } catch {
            print("❌ Error saving ride: \(error)")
            context.rollback()
        }
    }

    func fetchAllRides() -> [RideEntity] {
        let request: NSFetchRequest<RideEntity> = RideEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("❌ Error fetching rides: \(error)")
            return []
        }
    }
}
