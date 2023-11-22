//
//  TempView.swift
//  MetUCD
//
//  Created by Miaomiao Shi on 23/11/2023.
//

import SwiftUI

struct TempView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
            }
        }
        .padding(.horizontal) // Apply default padding to the horizontal edges only
        .background(Color(red: 0.941, green: 0.949, blue: 0.966))
        .edgesIgnoringSafeArea(.top) // This will allow the content to go behind the dynamic island
    }
}

#Preview {
    TempView()
}
