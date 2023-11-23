//
//  Heading.swift
//  MetUCD
//
//  Created by Miaomiao Shi on 23/11/2023.
//

import SwiftUI

struct Heading: View {
    var heading : String
    
    var body: some View {
        Text("\(heading)")
            .font(.system(size: 14))
            .foregroundColor(Color(red: 0.633, green: 0.632, blue: 0.657))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
}

#Preview {
    Heading(heading: "GEO")
}
