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
  func startGameLoop() {
    gameViewController.makeActive(for: currentPlayer)
    // p1 select soldier
    // p1 select direction
    // check p1 win -> end loop
    // loop
  }
}
