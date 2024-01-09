//
//  ContentView.swift
//  LanguageGame
//
//  Created by student on 09/01/2024.
//

import SwiftUI

struct ContentView: View {
    var en_words: [String] = ["Hello", "Mother", "Father", "Sister", "Brother"]
    
    var colors: [Color] = [.green, .blue, .red]
    
    @EnvironmentObject var viewModel: LanguageGameViewModel
    
    var body: some View {
        VStack {
            Text("Language Game").font(.largeTitle)
            
            cardDisplay()
            Spacer()
            levelButtonDisplay
        }
        .padding()
    }
    
    func cardDisplay() -> some View {
            let columns = [GridItem(.flexible(minimum: 20)), GridItem(.flexible(minimum: 20))]
            
            return VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.cards) {card in
                            CardView(card: card)
                                .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fill)
                                .onTapGesture {
                                    viewModel.choose(card)
                                }
                        }
                    }.foregroundColor(viewModel.level.color)
                }.onAppear(perform: {
                    viewModel.shuffle()
                })
                
                Button(action: {
                    viewModel.shuffle()
                }) {
                    Text("SHUFFLE")
                        .foregroundColor(viewModel.level.color)
                }
            }
        }
        
        var levelButtonDisplay: some View {
            return HStack {
                HStack {
                    LevelView(level: Level(color: colors[0], cardsNumber: en_words.count, words: en_words), sysIcon: en_words[0], content: "Level 1")
                    Spacer()
                    LevelView(level: Level(color: colors[1], cardsNumber: en_words.count, words: en_words), sysIcon: en_words[0], content: "Level 2")
                    Spacer()
                    LevelView(level: Level(color: colors[2], cardsNumber: en_words.count, words: en_words), sysIcon: en_words[0], content: "Level 3")
                }
            }
        }
}

#Preview {
    ContentView()
}
