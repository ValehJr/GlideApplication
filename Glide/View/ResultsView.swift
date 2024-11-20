//
//  ResultsView.swift
//  Glide
//
//  Created by Valeh Ismayilov on 20.11.24.
//

import SwiftUI
import MapKit

struct ResultsView: View {
    var searchResults: [MKMapItem]
    var onSelect: (MKMapItem) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(searchResults, id: \.self) { result in
                    Button(action: {
                        onSelect(result)
                    }) {
                        Text(result.name ?? "Unknown Place")
                            .font(.custom("FunnelSans-Medium", size: 24))
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                            .padding(.vertical)
                    }
                }
            }
            .padding()
        }
    }
}


#Preview {
    ResultsView(searchResults: [], onSelect: {_ in
        print("search")
    })
}
