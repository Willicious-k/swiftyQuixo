//
//  GameController.swift
//  swiftyQuixo
//
//  Created by 김성종 on 2018. 3. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation
import UIKit

class GameController {
  // MARK: session control, cascading initializers
  var sessionController: SessionController = SessionController()
  
  // received view controller
  var gameViewController: GameViewController!
  
  //MARK: soldiers will be passed to ViewController
  var soldiers: [[Soldier]] = []
  
  var currentPlayer: Soldier.SoldierSide = .p1
  var winner: Soldier.SoldierSide = .none
  
  // MARK: Data setup
  func makeSoldiers(boardFrame: CGRect) -> [[Soldier]]{
    var targetArray: [[Soldier]] = []
    for i in 0..<5 {
      targetArray.append([])
      for j in 0..<5 {
        let targetSoldier = Soldier(i: i, j: j)
        targetArray[i].append(targetSoldier)
      }
    }
    soldiers = targetArray
    return targetArray
  }
  
  // MARK: Turn control + log handling
  func startTurn() {
    gameViewController.makeActive(for: currentPlayer)
  }
  
  func playerMoved(from: Soldier, to: Soldier) {
    // select slide direction
    if (from.location.0 == to.location.0) { // same x axis -> slide y axis
      if (from.location.1 > to.location.1 ) { // 아랫돌 빼서 위에 괴기, slide down
        let c = from.location.1 - to.location.1
        for i in 0..<c {
          let source = soldiers[from.location.0][from.location.1 - (i+1)].side
          soldiers[from.location.0][from.location.1 - i].side = source
        }
        soldiers[to.location.0][to.location.1].side = currentPlayer
      } else { // 윗돌 빼서 아래에 괴기, slide up
        let c = to.location.1 - from.location.1
        for i in 0..<c {
          let source = soldiers[from.location.0][from.location.1 + (i+1)].side
          soldiers[from.location.0][from.location.1 + i].side = source
        }
        soldiers[to.location.0][to.location.1].side = currentPlayer
      }
    } else if (from.location.1 == to.location.1) { // same y axis -> slide x axis
      if (from.location.0 > to.location.0) { // left to right
        let c = from.location.0 - to.location.0
        for i in 0..<c {
          let source = soldiers[from.location.0 - (i+1)][from.location.1].side
          soldiers[from.location.0 - i][from.location.1].side = source
        }
        soldiers[to.location.0][to.location.1].side = currentPlayer
      } else { // right to left
        let c = to.location.0 - from.location.0
        for i in 0..<c {
          let source = soldiers[from.location.0 + (i+1)][from.location.1].side
          soldiers[from.location.0 + i][from.location.1].side = source
        }
        soldiers[to.location.0][to.location.1].side = currentPlayer
        }
      }
    
    winner = checkWinner(target: to)
    
    //MARK: early exit with winner
    if (winner != .none) {
      gameViewController.finishGame(winner: winner)
    }
    
    // game continues..
    // player change
    if (currentPlayer == .p1) {
      currentPlayer = .p2
    } else {
      currentPlayer = .p1
    }
    gameViewController.reloadData()
  }
  
  func checkWinner(target: Soldier) -> Soldier.SoldierSide {
    var x = true
    var y = true
    var slash = false
    // x axis
    for i in 0..<5 {
      if (soldiers[i][target.location.1].side != currentPlayer) {
        x = false
        break
      }
    }
    // y axis
    for j in 0..<5 {
      if (soldiers[target.location.0][j].side != currentPlayer) {
        y = false
        break
      }
    }
    // diagonal check if needed
    if (target.location == (0,0) || target.location == (4,4)) {
      slash = true
      for i in 0..<5 {
        if (soldiers[i][i].side != currentPlayer) {
          slash = false
        }
      }
    } else if (target.location == (0, 4) || target.location == (4, 0)) {
      slash = true
      for i in 0..<5 {
        if (soldiers[i][4-i].side != currentPlayer) {
          slash = false
        }
      }
    }
    
    if (x || y || slash) {
      return currentPlayer
    }
    return .none
  }
  
  
}
