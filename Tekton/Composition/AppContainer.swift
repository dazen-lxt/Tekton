//
//  AppContainer.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import Foundation

struct AppContainer {
    
    private let coreDataStack = CoreDataStack()
    
    func makeCurrentRideView() -> CurrentRideView {
        let rideStorage = RideStorage(context: coreDataStack.context)
        let rideService = RideTrackingService()
        let rideViewModel = CurrentRideViewModel(rideService: rideService, rideStorage: rideStorage)
        return CurrentRideView(viewModel: rideViewModel)
    }
    
    func makeRidesListView() -> RidesListView {
        let rideStorage = RideStorage(context: coreDataStack.context)
        let rideViewModel = RidesListViewModel(storage: rideStorage)
        return RidesListView(viewModel: rideViewModel)
    }
}
