//
//  Ride.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import Foundation

struct Ride: Identifiable {
    let id: String
    let date: Date
    let duration: Double
    let distance: Double
    let startPoint: String
    let endPoint: String
}
