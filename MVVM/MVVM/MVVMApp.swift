//
//  MVVMApp.swift
//  MVVM
//
//  Created by Joey Zhang on 2024/10/17.
//

import SwiftUI
import DataAccess

@main
struct MVVMApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(coordinator: .init())
        }
    }
}
