//
//  GameController.swift
//  swiftyQuixo
//
//  Created by 김성종 on 2018. 3. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

class GameController {
  
  // MARK: session control, cascading initializers
  var sessionController: SessionController = SessionController()
  
  //MARK: this will be passed to ViewController
  var soldiers: [[Soldier]] = []
  
  // MARK: Data setup
  func makeSoldiers() -> [[Soldier]]{
    var targetArray: [[Soldier]] = []
    for i in 0..<5 {
      targetArray.append([])
      for j in 0..<5 {
        let targetSoldier = Soldier(location: (i, j), side: .none)
        targetArray[i].append(targetSoldier)
      }
    }
    soldiers = targetArray
    return targetArray
  }
  
  // MARK: Turn control, create logs
  
}
