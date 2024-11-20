//
//  SearchResult.swift
//  Glide
//
//  Created by Valeh Ismayilov on 20.11.24.
//

import CoreLocation
import SwiftUI

struct SearchResult: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.coordinate = coordinate
    }
}
