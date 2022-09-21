//
//  MyPantryApp.swift
//  MyPantry
//
//  Created by Ramandeep Singh on 18/09/22.
//

import SwiftUI
import FirebaseCore


@main
struct MyPantryApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
