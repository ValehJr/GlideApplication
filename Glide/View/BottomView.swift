//
//  BottomView.swift
//  Glide
//
//  Created by Valeh Ismayilov on 20.11.24.
//

import SwiftUI

struct BottomView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var isEditingField: Bool
    @State var seachQuery: String
    @State var showingAlert: Bool
    
    var body: some View {
        HStack {
            if !isEditingField && !seachQuery.isEmpty {
                Button(action: {
                    showingAlert = true
                }) {
                    ZStack {
                        BottomButtonView(imageName: "bell.fill")
                    }
                }//Button
                .padding(.leading, 8)
                .alert("The bus driver has been notified.", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            } else {
                ZStack {
                    BottomButtonView(imageName: "bell.fill")
                    Circle()
                        .fill(Color.black.opacity(0.6))
                        .stroke(colorScheme == .dark ? .customWhite : .backgroundBlack,lineWidth: 0.5)
                        .frame(width: 45, height: 45)
                }//Z
                .padding(.leading, 8)
            }
            Spacer()
            Button(action: {
                showingAlert.toggle()
            }, label: {
                BottomButtonView(imageName: "exclamationmark.triangle.fill")
                
            })//Button
            .padding(.trailing, 8)
        }//H
        .frame(width: 120, height: 60)
        .background(
            Capsule()
                .fill(colorScheme == .dark ? .backgroundBlack : .customWhite)
                .stroke(colorScheme == .dark ? .customWhite : .backgroundBlack,lineWidth: 0.5)
        )
    }
}

#Preview {
    BottomView(isEditingField: false, seachQuery: "", showingAlert: false)
}
