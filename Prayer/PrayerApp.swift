//
//  PrayerApp.swift
//  Prayer
//
//  Created by Dmitry Tokarev on 14.08.2021.
//

import SwiftUI

@main
struct PrayerApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: viewRouter)
        }
    }
}
