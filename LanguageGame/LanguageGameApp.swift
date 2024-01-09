//
//  LanguageGameApp.swift
//  LanguageGame
//
//  Created by student on 09/01/2024.
//

import SwiftUI

@main
struct LanguageGameApp: App {
    @StateObject var viewModel = LanguageGameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }
    }
}
