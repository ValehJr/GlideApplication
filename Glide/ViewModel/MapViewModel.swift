//
//  SearchFieldViewModel.swift
//  Glide
//
//  Created by Valeh Ismayilov on 17.11.24.
//

import SwiftUI
import MapKit


@Observable
class MapViewModel {
    
    var locationManager = LocationManager()
    var textToSearch:String = ""
    
    func searchForLocation() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = textToSearch
        
        let search = MKLocalSearch(request: request)
        DispatchQueue(label: "search_thread").async {
            search.start { [weak self] response, error in
                guard let response = response, let firstResult = response.mapItems.first else {
                    print("Error searching for location: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                print(firstResult)
                let coordinate = firstResult.placemark.coordinate
                self?.locationManager.cameraPosition = .region(MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
                ))
            }
        }
    }
    
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
