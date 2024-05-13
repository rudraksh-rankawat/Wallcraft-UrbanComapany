//
//  WallcraftUCApp.swift
//  WallcraftUC
//
//  Created by Rudraksh Rankawat on 13/05/24.
//

import SwiftUI

@main
struct WallcraftUCApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
