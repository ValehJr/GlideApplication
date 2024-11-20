//
//  SearchFieldView.swift
//  Glide
//
//  Created by Valeh Ismayilov on 15.11.24.
//

import SwiftUI

struct SearchFieldView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var text: String
    @State var textfieldFocused:Bool = false
    
    var placeholder = "Where do you want to go?"
    var onSearch: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .stroke(colorScheme == .dark ? .customWhite : .backgroundBlack,lineWidth: 0.5)
                .fill(colorScheme == .dark ? .backgroundBlack : .customWhite)
                .frame(maxWidth: 330,maxHeight: 45)
                .shadow(radius: 3,x: 3, y: 3)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(colorScheme == .dark ? .customWhite : .customOpenBlack)
                    .padding(.leading,20)
                
                ZStack(alignment:.leading) {
                    
                    Text(placeholder)
                        .foregroundStyle(colorScheme == .dark ? .customWhite : .customOpenBlack)
                        .opacity(text.isEmpty ? 1 : 0)
                    
                    
                    
                    TextField("", text: $text)
                        .foregroundStyle(colorScheme == .dark ? .customWhite : .customOpenBlack)
                        .autocorrectionDisabled(true)
                        .keyboardType(.alphabet)
                        .onSubmit {
                            onSearch()
                        }
                    
                }
                .frame(maxWidth: 275,maxHeight: 45)
                .padding(.trailing,15)
                
            }
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var text = ""
    SearchFieldView(text: $text,onSearch: {
        print("Searched")
    })
}
