//
//  LanguageGameModel.swift
//  LanguageGame
//
//  Created by student on 09/01/2024.
//

import Foundation

struct LanguageGameModel<CardContent:Equatable> {
    private(set) var cards: [Card]
    let cards_sp = ["Hola", "Adios", "Madre", "Fadre", "Hermana", "Hermano", "Tia", "Tio", "Gato", "Perro", "Caballo", "Pollo", "Manzana", "Agua", "Amor", "Raton", "Rana", "Lluvia", "Niebla", "Sol", "Invierno", "Primavera", "Verano", "Otono"]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        var randomNumbers: [Int] = []
        for _ in 0..<max(2,numberOfPairsOfCards){
            var number = Int.random(in: 0..<cards_sp.count)
            while randomNumbers.contains(number){
                number = Int.random(in: 0..<cards_sp.count)
            }
            randomNumbers.append(number)
        }
        for pairIndex in 0..<max(2,numberOfPairsOfCards){
            let content = cardContentFactory(randomNumbers[pairIndex])
            cards.append(Card(content: content, matchId: pairIndex, isEnglish: true, id: "\(pairIndex+1)a"))
            cards.append(Card(content: cards_sp[randomNumbers[pairIndex]] as! CardContent, matchId: pairIndex, isEnglish: false, id: "\(pairIndex+1)b"))
        }
    }
    
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            if !cards[chosenIndex].isFolded && !cards[chosenIndex].isMatched{
                if let potentialMatchedIndex = indexOfOneAndOnlyFaceUpCard{
                    if cards[chosenIndex].matchId == cards[potentialMatchedIndex].matchId {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchedIndex].isMatched = true
                    }
                } else {
                    indexOfOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFolded = true
            }
        }
    }
    
    func index(of card:Card) -> Int?{
        for index in cards.indices{
            if cards[index].id == card.id{
                return index
            }
        }
        return nil
    }
        
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFolded}.only }
        set { cards.indices.forEach { cards[$0].isFolded = (newValue == $0) } }
    }
        
    mutating func shuffle(){
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        var isFolded: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var matchId: Int
        var isEnglish: Bool
        
        var id: String
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
