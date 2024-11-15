//
//  MapView.swift
//  Glide
//
//  Created by Valeh Ismayilov on 15.11.24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var locationManager = LocationManager()
    var body: some View {
        Map(position: $locationManager.cameraPosition) {
            
        }
        .mapControls{
            MapUserLocationButton()
        }
        .onAppear {
            locationManager.checkIfLocationServicesAreEnabled()
        }
    }
}

#Preview {
    MapView()
}
