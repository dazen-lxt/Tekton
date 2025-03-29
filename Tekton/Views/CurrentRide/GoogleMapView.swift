//
//  GoogleMapView.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    @Binding var route: [CLLocationCoordinate2D]
    @Binding var userLocation: CLLocationCoordinate2D?

    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: userLocation?.latitude ?? 0,
                                              longitude: userLocation?.longitude ?? 0,
                                              zoom: 15.0)
        let mapView = GMSMapView()
        mapView.camera = camera
        mapView.delegate = context.coordinator
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.clear()
        if let location = userLocation {
            let camera = GMSCameraPosition.camera(withLatitude: location.latitude,
                                                  longitude: location.longitude,
                                                  zoom: 15.0)
            mapView.animate(to: camera)
        }
        let path = GMSMutablePath()
        for coordinate in route {
            path.add(coordinate)
        }
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .blue
        polyline.strokeWidth = 5.0
        polyline.map = mapView
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: GoogleMapView

        init(_ parent: GoogleMapView) {
            self.parent = parent
        }
    }
}
