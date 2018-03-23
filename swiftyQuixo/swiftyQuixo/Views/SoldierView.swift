//
//  SoldierView.swift
//  swiftyQuixo
//
//  Created by 김성종 on 2018. 3. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class SoldierView: UIView {
  
  let strings: [String] = ["?","◼︎","×"]
  
  // MARK: inits
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.frame = frame
  }
  
  // MARK: data injection
  var data: Soldier! {
    didSet {
      switch data.side {
      case .none:
        print()
      case .p1:
        print()
      case .p2:
        print()
      }
    }
  }
}
