//
//  PlayerIconView.swift
//  shengji-ios
//
//  Created by Kevin Peng on 2020-09-26.
//

import SwiftUI

protocol PlayerProtocol {
  var name: String { get }
  var team: Int { get }
  var id: Int { get }
}

struct Player: PlayerProtocol {
  let name: String
  let team: Int
  let id: Int
}

struct Frame: ViewModifier {
  let color: Color
  func body(content: Content) -> some View {
    content
      .padding()
      .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      .border(color, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
  }
}

struct TeamFrame: ViewModifier {
  let team: Int
  
  func body(content: Content) -> some View {
    content
      .modifier(Frame(color: color(for: team)))
  }
  
  private func color(for team: Int) -> Color {
    switch team {
    case 1:
      return .red
    case 2:
      return .blue
    default:
      return .primary
    }
  }
}

struct PlayerIconView: View {
  let player: PlayerProtocol
  
  var body: some View {
    Text(player.name)
      .modifier(TeamFrame(team: player.team))
  }
}

struct PlayerIconView_Previews: PreviewProvider {
  static var previews: some View {
    PlayerIconView(
      player: Player(name: "AD", team: 2, id: 1)
    )
  }
}
