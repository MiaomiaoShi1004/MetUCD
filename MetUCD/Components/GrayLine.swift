//
//  GrayLine.swift
//  MetUCD
//
//  Created by Miaomiao Shi on 23/11/2023.
//

import SwiftUI

struct GrayLine: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color(red: 0.901, green: 0.901, blue: 0.916))
            .padding(.horizontal)
    }
}

#Preview {
    GrayLine()
}
