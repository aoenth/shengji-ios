//
//  PlayerIconView.swift
//  shengji-ios
//
//  Created by Kevin Peng on 2020-09-26.
//

import SwiftUI

protocol PlayerProtocol {
  var name: String { get }
  var teammate: Int { get }
  var id: Int { get }
}

struct PlayerIconView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PlayerIconView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerIconView()
    }
}
