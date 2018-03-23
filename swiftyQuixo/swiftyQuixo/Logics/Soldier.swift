//
//  Soldier.swift
//  swiftyQuixo
//
//  Created by 김성종 on 2018. 3. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation

struct Soldier {
  var location: (Int, Int) = (0, 0)
  var side: SoldierSide = .none
  
  enum SoldierSide {
    case none
    case p1
    case p2
  }
}
