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
    var keyboardHeight: CGFloat = 0
    var markerCoordinate: CLLocationCoordinate2D? = nil
    var searchResultName:String?
    var searchResult:MKMapItem?
    var isEditingField: Bool = false
    var showingAlert: Bool = false
    
    func setupKeyboardHandling() {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { [weak self] notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    withAnimation(.easeInOut(duration: 0.23)) {
                        self?.keyboardHeight = keyboardFrame.height
                    }
                }
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { [weak self] _ in
                withAnimation(.easeInOut(duration: 0.23)) {
                    self?.keyboardHeight = 0
                }
            }
        }

        func removeKeyboardObservers() {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
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
                self?.searchResultName = firstResult.name
                self?.searchResult = firstResult
                let coordinate = firstResult.placemark.coordinate
                self?.markerCoordinate = coordinate
                self?.locationManager.cameraPosition = .region(MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
                ))
            }
        }
    }
}
