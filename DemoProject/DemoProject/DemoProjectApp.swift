//
//  DemoProjectApp.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.07.2022.
//

import SwiftUI

@main
struct DemoProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
