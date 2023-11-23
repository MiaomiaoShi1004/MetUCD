//
//  IconText.swift
//  MetUCD
//
//  Created by Miaomiao Shi on 23/11/2023.
//

import SwiftUI

struct IconText: View {
    var logo: String
    var value: String
    
    var body: some View {
        HStack (spacing: 10) {
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 30, height: 20)
                .padding([.vertical], 10)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
            
//            Spacer()
            
            Text(value)
//                .padding()
                .lineLimit(1)
//                .padding([.trailing], 10)
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        }
//        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    IconText(logo: "sunrise", value: "14:53")
}
