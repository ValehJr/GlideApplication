//
//  Constants.swift
//  Glide
//
//  Created by Valeh Ismayilov on 20.11.24.
//

import SwiftUI

let rowSpacing:CGFloat = 10
var gridLayout: [GridItem] {
   return Array(repeating: GridItem(.flexible(),spacing: rowSpacing), count: 2)
}
