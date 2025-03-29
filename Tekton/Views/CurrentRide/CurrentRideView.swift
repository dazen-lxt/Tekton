//
//  ContentView.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import GoogleMaps
import SwiftUI

struct CurrentRideView: View {
    
    @ObservedObject private var viewModel: CurrentRideViewModel
    
    // MARK: - Initializer
    init(viewModel: CurrentRideViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            GoogleMapView(route: $viewModel.route, userLocation: $viewModel.currentLocation)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                if viewModel.isTracking {
                    Text(viewModel.timerString)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(12)
                        .background(.white.opacity(0.9))
                        .cornerRadius(12)
                        .padding(.bottom, 8)
                    
                    Button("Stop") {
                        viewModel.stopTracking()
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                } else if viewModel.hasRideEnded {
                    RideSummaryView(
                        duration: viewModel.timerString,
                        distance: viewModel.formattedDistance,
                        onStore: {
                            Task {
                                await viewModel.storeRide()
                            }
                        },
                        onDelete: {
                            viewModel.endRide()
                        }
                    )
                } else {
                    Button("Start") {
                        viewModel.startTracking()
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(10)
                    .padding(.bottom, 32)
                }
            }
            .padding()
            .alert("Your progress has been correctly stored!", isPresented: $viewModel.showSaveConfirmation) {
                Button("OK", role: .cancel) { }
            }
        }
        .overlay(
            Group {
                if viewModel.isLoading {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    ProgressView("Saving...")
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                }
            }
        )
        .navigationTitle("Current Ride")
    }
}
