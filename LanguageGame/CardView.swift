//
//  CardView.swift
//  LanguageGame
//
//  Created by student on 09/01/2024.
//

import SwiftUI

struct CardView: View {
    var card: LanguageGameModel<String>.Card
    
    init(card: LanguageGameModel<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .strokeBorder(lineWidth: 2)
                Text(card.content).font(.title)
            }.opacity(card.isFolded ? 1 : 0)
            RoundedRectangle(cornerRadius: 25)
                .fill()
                .opacity(card.isFolded ? 0 : 1)
        }
        .opacity(card.isFolded || !card.isMatched ? 1 : 0)
        
    }
}
