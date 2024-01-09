//
//  LanguageGameViewModel.swift
//  LanguageGame
//
//  Created by student on 09/01/2024.
//

import SwiftUI

class LanguageGameViewModel: ObservableObject {
    private static let en_words: [String] = ["Hello", "Goodbye", "Mother", "Father", "Sister", "Brother", "Aunt", "Uncle", "Cat", "Dog", "Horse", "Chicken", "Apple", "Water", "Love"]
    
    private static func createMemoGame() -> LanguageGameModel<String>{
            return LanguageGameModel<String>(numberOfPairsOfCards: en_words.count){ index in
                if en_words.indices.contains(index){
                    return en_words[index]
                }
                else{
                    return "??"
                }
                    
            }
        }
        
        private func reloadLanguageGame() -> LanguageGameModel<String>{
            return LanguageGameModel<String>(numberOfPairsOfCards: level.cardsNumber){ index in
                if level.words.indices.contains(index){
                    shuffle()
                    return level.words[index]
                }
                else{
                    return "??"
                }
                    
            }
        }
        
        @Published private var model: LanguageGameModel<String> = createMemoGame()
        
        @Published var level: Level = Level(color: Color.blue, cardsNumber: en_words.count, words: en_words)
        
        var cards: Array<LanguageGameModel<String>.Card>{
            return model.cards
        }
        
        func shuffle(){
            model.shuffle()
        }
        
        func choose(_ card: LanguageGameModel<String>.Card){
            model.choose(card)
        }
        
        func changeAppLevel(level: Level){
            self.level = level
            model = reloadLanguageGame()
            shuffle()
        }
}
