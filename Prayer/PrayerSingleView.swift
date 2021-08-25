//
//  PrayerSingleView.swift
//  Prayer
//
//  Created by Dmitry Tokarev on 14.08.2021.
//

import SwiftUI

struct PrayerSingleView: View {
    
    let name = "Фаджр"
    let timeInterval = "03:56 - 04:34"
    
    let rectangleSideSize: CGFloat
    let rectangleInnerSize: CGFloat
    
    @State private var active = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(active ? Color(white: 0.9, opacity: 0.8) : Color(white: 1.0, opacity: 1))
                .frame(width: rectangleSideSize / 3.2, height: rectangleSideSize / 3.2, alignment: .center)
            VStack {
                Text(Image(systemName: active ? "bell.fill" : "bell.slash.fill"))
            }.frame(width: rectangleInnerSize / 3 - 20, height: rectangleInnerSize / 3 - 20, alignment: .topTrailing)
            VStack(alignment: .leading) {
                Text(name)
                Text(timeInterval)
                    .font(.footnote)
            }.frame(width: rectangleInnerSize / 3  - 20, height: rectangleInnerSize / 3 - 20, alignment: .bottomLeading)
        }
        
        .onTapGesture {
            active.toggle()
        }
        
    }
}

struct PrayerSingleView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerSingleView(rectangleSideSize: UIScreen.screenWidth, rectangleInnerSize: UIScreen.screenWidth)
    }
}
