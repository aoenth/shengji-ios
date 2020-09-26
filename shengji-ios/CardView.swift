//
//  ContentView.swift
//  shengji-ios
//
//  Created by Kevin Peng on 2020-09-26.
//

import SwiftUI

struct Card: CardProtocol {
  let suit: Suit
  let rank: Rank
  let deckNumber: Int
  
  var id: Int {
    if rank == .leftBower {
      return 112 + deckNumber - 1
    }
    else if rank == .rightBower {
      return 114 + deckNumber - 1
    }
    else{
      return 8 * rank.rawValue + suit.rawValue + (deckNumber - 1) * 4
    }
  }
}

enum Suit: Int {
  case spades, hearts, diamonds, clubs, leftBower, rightBower
}

extension Suit: CustomStringConvertible {
  public var description: String {
    switch self {
    case .spades:
      return "♠️"
    case .hearts:
      return "❤️"
    case .diamonds:
      return "♦️"
    case .clubs:
      return "♣️"
    case .leftBower:
      return "Left Bower"
    case .rightBower:
      return "Right Bower"
    }
  }
}

enum Rank: Int, CaseIterable {
  case ace = 1, two, three, four, five, six, seven, eight, nine, ten
  case jack, queen, king, leftBower, rightBower
}

extension Card {
  init(id: Int) {
    guard 8 ... 115 ~= id else {
      fatalError("Unable to initialize card. Invalid ID")
    }
    if id >= 114 {
      self.suit = .rightBower
      self.rank = .rightBower
      self.deckNumber = id % 114 + 1
    } else if id >= 112 {
      self.suit = .leftBower
      self.rank = .leftBower
      self.deckNumber = id % 112 + 1
    } else {
      let suit = id % 4
      self.suit = Suit(rawValue: suit)!
      
      let rank = id / 8
      self.rank = Rank(rawValue: rank)!
      
      let deckNumber = id % 8 < 4 ? 1 : 2
      self.deckNumber = deckNumber
    }
  }
}

protocol CardProtocol {
  var suit: Suit { get }
  var rank: Rank { get }
  var deckNumber: Int { get }
  var id: Int { get }
}

struct CardBorder: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 5)
      .stroke(Color.gray)
      .foregroundColor(.white)
  }
}

struct CardFaceNormal: View {
  let rank: Int
  let suit: Character 
  var body: some View {
    VStack {
      Text("\(rank)")
      Text(String(suit))
        .font(.caption)
    }
  }
}

struct CardFaceJoker: View {
  var body: some View {
    VStack {
      Text("J")
      Text("O")
      Text("K")
      Text("E")
      Text("R")
    }
    .font(.caption)
  }
}

struct CardFaceLeftBower: View {
  var body: some View {
    CardFaceJoker()
  }
}

struct CardFaceRightBower: View {
  var body: some View {
    CardFaceJoker()
      .foregroundColor(.red)
  }
}

struct CardFace: View {
  let card: CardProtocol
  var body: some View {
    switch card.suit {
    case .rightBower:
      CardFaceRightBower()
    case .leftBower:
      CardFaceLeftBower()
    default:
      CardFaceNormal(
        rank: card.rank.rawValue, 
        suit: card.suit.description.first!
      )
    }
  }
}

extension HorizontalAlignment {
  private enum CardAlignment: AlignmentID {
    static func defaultValue(in d: ViewDimensions) -> CGFloat {
      return d.width / 5
    }
  }
  
  static let horizontalCardAlignment = HorizontalAlignment(CardAlignment.self)
}

extension VerticalAlignment {
  private enum CardAlignment: AlignmentID {
    static func defaultValue(in d: ViewDimensions) -> CGFloat {
      return d.width / 10
    }
  }
  
  static let verticalCardAlignment = VerticalAlignment(CardAlignment.self)
}


struct CardView: View {
  let card: CardProtocol
  var body: some View {
    let alignment = Alignment(
      horizontal: .horizontalCardAlignment,
      vertical: .verticalCardAlignment
    )
    ZStack(alignment: alignment) {
      CardBorder()
      CardFace(card: card)
        .alignmentGuide(
          .horizontalCardAlignment,
          computeValue: { d in d[HorizontalAlignment.center] }
        )
        .alignmentGuide(
          .verticalCardAlignment,
          computeValue: { d in d[.top] }
        )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: Card(suit: .clubs, rank: .three, deckNumber: 1))
      .previewLayout(.fixed(width: 63, height: 88))
    CardView(card: Card(suit: .clubs, rank: .ten, deckNumber: 1))
      .previewLayout(.fixed(width: 63, height: 88))
    CardView(card: Card(suit: .leftBower, rank: .leftBower, deckNumber: 1))
      .previewLayout(.fixed(width: 63, height: 88))
    CardView(card: Card(suit: .rightBower, rank: .rightBower, deckNumber: 1))
      .previewLayout(.fixed(width: 63, height: 88))
  }
}
