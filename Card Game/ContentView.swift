//
//  ContentView.swift
//  Card Game
//
//  Created by Alexander Burneikis on 6/6/2022.
//

/*
 .onTapGesture {
 if cards.count > 0 {
 card1 = cards.randomElement()!
 cards.remove(at: cards.firstIndex(of: card1)!)
 }
 }
 */

import SwiftUI
let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

let possibleCards = ["1S", "2S", "3S", "4S", "5S", "6S", "7S", "8S", "9S", "10S", "11S", "12S", "13S","1D", "2D", "3D", "4D", "5D", "6D", "7D", "8D", "9D", "10D", "11D", "12D", "13D","1C", "2C", "3C", "4C", "5C", "6C", "7C", "8C", "9C", "10C", "11C", "12C", "13C","1H", "2H", "3H", "4H", "5H", "6H", "7H", "8H", "9H", "10H", "11H", "12H", "13H"]

var cards = possibleCards

struct ContentView: View {
    @State var card1 = cards.randomElement()!
    @State var card2 = cards.randomElement()!
    @State var card3 = "gray_back"
    
    func startUp() {
        card3 = "gray_back"
        cards = possibleCards
        card1 = cards.randomElement()!
        card2 = cards.randomElement()!
        while (card1 == card2) {
            self.card2 = cards.randomElement()!
        }
        cards.remove(at: cards.firstIndex(of: card2)!)
        cards.remove(at: cards.firstIndex(of: card1)!)
    }
    
    func getValue() -> Int{
        let card1Value = Int(card1.trimmingCharacters(in: CharacterSet(charactersIn: "SDCH")))!
        let card2Value = Int(card2.trimmingCharacters(in: CharacterSet(charactersIn: "SDCH")))!
        return card1Value + card2Value
    }
    func getTotalValue() -> Int{
       return getValue() + Int(card3.trimmingCharacters(in: CharacterSet(charactersIn: "SDCH")))!
    }
    func isBust() -> Bool{
        if (getTotalValue() > 21) {
            return true
        }
        return false
    }
    func hit() {
        card3 = cards.randomElement()!
        if (isBust()) {
            print("Lose")
        }
        else {
            print("Win")
        }
    }
    func stand() {
        card3 = cards.randomElement()!
        if (isBust()) {
            print("Win")
        }
        else {
            print("Lose")
        }
    }
    func newCard() -> some View{
        return Image(card3)
            .resizable()
            .scaledToFit()
            .onTapGesture{
                hit()
            }
    }
    func showCards() -> some View{
        return HStack(spacing: 0) {
            Image(card1)
                .resizable()
                .scaledToFit()
                .padding(10)
                .onAppear{
                    cards.remove(at: cards.firstIndex(of: card1)!)
                }
            Image(card2)
                .resizable()
                .scaledToFit()
                .padding(10)
                .onAppear {
                    while (card1 == card2) {
                        self.card2 = cards.randomElement()!
                    }
                    cards.remove(at: cards.firstIndex(of: card2)!)
                    
                }
        }
        .onTapGesture {
            stand()
        }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                newCard()
                showCards()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
