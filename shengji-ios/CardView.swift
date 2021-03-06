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

extension Suit {
  public var imageName: String {
    switch self {
    case .spades:
      return "suit.spade.fill"
    case .hearts:
      return "suit.heart.fill"
    case .diamonds:
      return "suit.diamond.fill"
    case .clubs:
      return "suit.club.fill"
    default:
      return "xmark.octagon.fill"
    }
  }
}

enum Rank: Int, CaseIterable {
  case ace = 1, two, three, four, five, six, seven, eight, nine, ten
  case jack, queen, king, leftBower, rightBower
}

extension Rank: CustomStringConvertible {
  var description: String {
    switch self {
    case .ace:
      return "A"
    case .jack:
      return "J"
    case .queen:
      return "Q"
    case .king:
      return "K"
    case .leftBower, .rightBower:
      return ""
    default:
      return "\(rawValue)"
    }
  }
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

struct CardBorderNormal: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 5)
      .stroke(Color.gray)
  }
}

struct CardBorderBower: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 5)
      .stroke(Color.white)
  }
}

struct CardLabelNormal: View {
  let rank: String
  let sfSymbolName: String 
  var body: some View {
    VStack {
      Text(rank)
        .foregroundColor(.black)
        .bold()
      Image(systemName: sfSymbolName)
        .foregroundColor(color(for: sfSymbolName))
    }
  }
  
  private func color(for symbol: String) -> Color {
    switch symbol {
    case "suit.spade.fill":
      return .black
    case "suit.heart.fill":
      return .red
    case "suit.diamond.fill":
      return .red
    case "suit.club.fill":
      return .black
    default:
      return .red
    }
  }
}

struct CardLabelLeftBower: View {
  var body: some View {
    EmptyView()
  }
}

struct CardLabelRightBower: View {
  var body: some View {
    EmptyView()
  }
}

struct CardLabel: View {
  let card: CardProtocol
  var body: some View {
    switch card.suit {
    case .rightBower:
      CardLabelRightBower()
    case .leftBower:
      CardLabelLeftBower()
    default:
      CardLabelNormal(
        rank: card.rank.description, 
        sfSymbolName: card.suit.imageName
      )
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

struct CardBackground: View {
  let card: CardProtocol
  var body: some View {
    switch card.suit {
    case .leftBower:
      Image("Left Bower")
        .resizable()
    case .rightBower:
      Image("Right Bower")
        .resizable()
    default:
      Color.white
    }
  }
}

struct CardBorder: View {
  let card: CardProtocol
  var body: some View {
    switch card.suit {
    case .leftBower, .rightBower:
      CardBorderBower()
    default:
      CardBorderNormal()
    }
  }
}

struct CardView: View {
  let card: CardProtocol
  var body: some View {
    let alignment = Alignment(
      horizontal: .horizontalCardAlignment,
      vertical: .verticalCardAlignment
    )
    ZStack(alignment: alignment) {
      Group {
        CardBackground(card: card)
        CardLabel(card: card)
      }
      .clipShape(RoundedRectangle(cornerRadius: 5))
      CardBorder(card: card)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Rectangle()
      CardView(card: Card(suit: .clubs, rank: .three, deckNumber: 1))
    }
    .previewLayout(.fixed(width: 63, height: 88))
    CardView(card: Card(suit: .clubs, rank: .ten, deckNumber: 1))
      .previewLayout(.fixed(width: 63, height: 88))
    CardView(card: Card(suit: .leftBower, rank: .leftBower, deckNumber: 1))
      .previewLayout(.fixed(width: 63, height: 88))
    CardView(card: Card(suit: .rightBower, rank: .rightBower, deckNumber: 1))
      .previewLayout(.fixed(width: 63, height: 88))
    CardView(card: Card(suit: .rightBower, rank: .rightBower, deckNumber: 1))
      .font(.system(size: 10, weight: .bold))
      .previewLayout(.fixed(width: 20, height: 28))
    CardView(card: Card(suit: .clubs, rank: .ten, deckNumber: 1))
      .font(.system(size: 10, weight: .bold))
      .previewLayout(.fixed(width: 20, height: 28))
  }
}
