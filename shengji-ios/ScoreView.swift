//
//  ScoreView.swift
//  shengji-ios
//
//  Created by Kevin Peng on 2020-09-26.
//

import SwiftUI

struct ScoreLabel: View {
  let score: Int
  var body: some View {
    Text("\(score)")
  }
}

struct JiLabel: View {
  let ji: Int
  var body: some View {
    Text("\(ji)")
  }
}

struct TeamScoreView: View {
  let team: Int
  let ji: Int
  let score: Int
  var body: some View {
    HStack {
      JiLabel(ji: ji)
        .padding(.leading)
      Spacer()
      ScoreLabel(score: score)
        .padding(.trailing)
    }
    .background(Color(team: team))
  }
}

struct ScoreView: View {
  let jis: (Int, Int)
  let scores: (Int, Int)
  var body: some View {
    HStack {
      Text("Score")
      VStack {
        TeamScoreView(team: 1, ji: jis.0, score: scores.0)
        TeamScoreView(team: 2, ji: jis.1, score: scores.1)
      }
    }
  }
}

struct ScoreView_Previews: PreviewProvider {
  static var previews: some View {
    ScoreView(jis: (2, 12), scores: (80, 0))
  }
}
