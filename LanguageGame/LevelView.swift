//
//  LevelView.swift
//  LanguageGame
//
//  Created by student on 09/01/2024.
//

import SwiftUI

struct LevelView: View {
    @EnvironmentObject var viewModel: LanguageGameViewModel
    
    var level: Level
    var sysIcon: String
    var content: String
    
    var body: some View {
        Button(action: {
                    viewModel.changeAppLevel(level: level)
                }, label: {
                    VStack {
                        Text(sysIcon).font(.title)
                        Text(content).foregroundColor(level.color)
                    }
                })
    }
}
