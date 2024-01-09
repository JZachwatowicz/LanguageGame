//
//  ContentView.swift
//  LanguageGame
//
//  Created by student on 09/01/2024.
//

import SwiftUI

struct ContentView: View {
    var en_words: [String] = ["Hello", "Goodbye", "Mother", "Father", "Sister", "Brother", "Aunt", "Uncle", "Cat", "Dog", "Horse", "Chicken", "Apple", "Water", "Love"]
    
    var colors: [Color] = [.green, .blue, .red]
    
    var icons: [String] = ["☀️", "🦉", "🪓"]
    
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
            let columns = [GridItem(.flexible(minimum: 80, maximum: 150)), GridItem(.flexible(minimum: 80, maximum: 150))]
            
            return VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.cards) {card in
                            CardView(card: card)
                                .aspectRatio(CGSize(width: 2, height: 1), contentMode: .fill)
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
                    LevelView(level: Level(color: colors[0], cardsNumber: en_words.count/4, words: en_words), sysIcon: icons[0], content: "Level 1")
                    Spacer()
                    LevelView(level: Level(color: colors[1], cardsNumber: en_words.count/2, words: en_words), sysIcon: icons[1], content: "Level 2")
                    Spacer()
                    LevelView(level: Level(color: colors[2], cardsNumber: en_words.count, words: en_words), sysIcon: icons[2], content: "Level 3")
                }
            }
        }
}

#Preview {
    ContentView()
}
