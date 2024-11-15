//
//  LocationManager.swift
//  Glide
//
//  Created by Valeh Ismayilov on 15.11.24.
//

import SwiftUI
import CoreLocation
import MapKit


@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    
    var trueNorthOffset: Double = 0.0
    
    var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.4093, longitude: 49.8671), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    
    var userLocation: CLLocationCoordinate2D? {
            didSet {
                if let userLocation = userLocation {
                    cameraPosition = MapCameraPosition.region(MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
                }
            }
        }
    
    func checkIfLocationServicesAreEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager = CLLocationManager()
                self.locationManager!.delegate = self
                self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager!.startUpdatingLocation()
                self.checkLocationAuthorization()
            } else {
                print("Turn the location services on")
            }
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted")
        case .denied:
            print("You have denied permission")
        case .authorizedAlways, .authorizedWhenInUse:
            if let userLocation = locationManager.location?.coordinate {
                self.userLocation = userLocation
            }
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        withAnimation {
            self.trueNorthOffset = newHeading.trueHeading.rounded()
        }
    }
}
