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
    @FocusState private var isFocused: Bool
    @Environment(\.colorScheme) var colorScheme
    @State private var selection: MapSelection<MKMapItem>?
    
    var body: some View {
        ZStack {
            Map(position: $vm.locationManager.cameraPosition, selection: $selection,scope: mapScope){
                UserAnnotation()
                
                if let searchResult = vm.searchResult {
                    Marker(item: searchResult)
                        .tag(MapSelection(searchResult))
                        .mapItemDetailSelectionAccessory(.callout)
                }
            }//Map
            .mapFeatureSelectionAccessory(.callout)
            .mapStyle(.standard)
            .overlay(alignment:.bottomTrailing) {
                
                MapUserLocationButton(scope: mapScope)
                    .buttonBorderShape(.circle)
                    .tint(colorScheme == .dark ? .customWhite : .backgroundBlack)
                    .padding(.trailing)
                    .padding(.bottom, max(vm.keyboardHeight,10))
                
            }
            .ignoresSafeArea(.keyboard)
            .mapScope(mapScope)
            .onAppear {
                vm.locationManager.checkIfLocationServicesAreEnabled()
                vm.setupKeyboardHandling()
            }
            .onDisappear {
                vm.removeKeyboardObservers()
            }
            .mapControlVisibility(.hidden)
            
            VStack {
                SearchFieldView(text: $vm.textToSearch,onSearch: vm.searchForLocation)
                    .focused($isFocused)
                Spacer()
                BottomView(isEditingField: vm.isEditingField, seachQuery: vm.textToSearch, showingAlert: vm.showingAlert)
            } //V
            
        } //Z
        .onTapGesture {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isFocused = false
            }
        }
    }
}

#Preview {
    MapView()
}
