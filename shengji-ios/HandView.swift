//
//  HandView.swift
//  shengji-ios
//
//  Created by Kevin Peng on 2020-09-26.
//

import SwiftUI

struct HandView: View {
  @Binding var cards: [CardProtocol]
  private let cardWidth: CGFloat = 62
  
  var body: some View {
    HStack(spacing: -36) {
        ForEach(cards.indices, id: \.self) { index in
          CardView(card: cards[index])
            .frame(width: cardWidth)
        }
    }
  }
}

struct HandView_Previews: PreviewProvider {
  static var previews: some View {
    HandView(
      cards: .init(
        get: {
          (8..<(8 + 23)).map(Card.init) + [
              Card(suit: .leftBower, rank: .leftBower, deckNumber: 1),
              Card(suit: .rightBower, rank: .rightBower, deckNumber: 1)
            ]
        },
        set: { _ in }
      )
    )
    .previewLayout(.fixed(width: 812 - 16, height: 88))
    
    HandView(
      cards: .init(
        get: {
          (8..<(8 + 17)).map(Card.init) + [
            Card(suit: .leftBower, rank: .leftBower, deckNumber: 1),
            Card(suit: .rightBower, rank: .rightBower, deckNumber: 1)
          ]
        },
        set: { _ in }
      )
    )
    .previewLayout(.fixed(width: 812 - 16, height: 88))
  
    HandView(
      cards: .init(
        get: {
          [Card(suit: .rightBower, rank: .rightBower, deckNumber: 1)]
        },
        set: { _ in }
      )
    )
    .previewLayout(.fixed(width: 812 - 16, height: 88))
  }
}
