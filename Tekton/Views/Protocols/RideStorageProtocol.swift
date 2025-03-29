//
//  RideStorageProtocol.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import CoreLocation
import Foundation

protocol RideStorageProtocol {

    func saveRide(
        startDate: Date,
        duration: Double,
        distance: Double,
        startPoint: String,
        endPoint: String
    )
    func fetchAllRides() -> [RideEntity]
}
