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
    @Namespace var mapScope
    var body: some View {
        ZStack {
            Map(position: $locationManager.cameraPosition,scope: mapScope){
                UserAnnotation()
            }
            .overlay(alignment:.bottomTrailing) {
                    MapUserLocationButton(scope: mapScope)
                    .padding(.trailing)
                
            }
            .buttonBorderShape(.circle)
            .mapScope(mapScope)
            .onAppear {
                locationManager.checkIfLocationServicesAreEnabled()
            }
            .mapControlVisibility(.hidden)
            
        }//Z
    }
}

#Preview {
    MapView()
}
