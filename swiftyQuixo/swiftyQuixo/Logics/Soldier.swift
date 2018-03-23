//
//  Soldier.swift
//  swiftyQuixo
//
//  Created by 김성종 on 2018. 3. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import Foundation
import UIKit

class Soldier {
  var location: (Int, Int) = (0, 0)
  var side: SoldierSide = .none
  var isSelected: Bool = false
  
  init(i: Int, j: Int) {
    self.location = (i, j)
  }
  
  enum SoldierSide: Int {
    case none = 0
    case p1 = 1
    case p2 = 2
  }
}
