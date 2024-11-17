//
//  MapView.swift
//  Glide
//
//  Created by Valeh Ismayilov on 15.11.24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var vm = MapViewModel()
    @Namespace var mapScope
    
    var body: some View {
        ZStack {
            Map(position: $vm.locationManager.cameraPosition,scope: mapScope){
                UserAnnotation()
            }//Map
            .mapStyle(.standard)
            .overlay(alignment:.bottomTrailing) {
                MapUserLocationButton(scope: mapScope)
                    .padding(.trailing)
            }
            .buttonBorderShape(.circle)
            .mapScope(mapScope)
            .onAppear {
                vm.locationManager.checkIfLocationServicesAreEnabled()
            }
            .mapControlVisibility(.hidden)
            
            VStack {
                SearchFieldView(text: $vm.textToSearch,onSearch: vm.searchForLocation)
                Spacer()
            } //V
            
        } //Z
        .onTapGesture {
            vm.dismissKeyboard()
        }
    }
}

#Preview {
    MapView()
}
