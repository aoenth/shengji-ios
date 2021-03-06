//
//  TableView.swift
//  shengji-ios
//
//  Created by Kevin Peng on 2020-09-26.
//

import SwiftUI

struct TableView: View {
  var body: some View {
    HandView(
      cards: 
        (8..<(8 + 17)).map(Card.init) + [
          Card(suit: .leftBower, rank: .leftBower, deckNumber: 1),
          Card(suit: .rightBower, rank: .rightBower, deckNumber: 1)
        ]
    )
    .frame(maxHeight: 88)
  }
}

struct TableView_Previews: PreviewProvider {
  static var previews: some View {
    TableView()
      .previewLayout(.fixed(width: 812, height: 375))
  }
}
