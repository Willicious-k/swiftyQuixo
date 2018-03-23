//
//  SoldierView.swift
//  swiftyQuixo
//
//  Created by 김성종 on 2018. 3. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

class SoldierView: UIView {
  
  let faceString: [String] = ["?","✪","★"]
  
  var face: UILabel!
  
  // MARK: inits
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.frame = frame
    
    layer.cornerRadius = 28
    layer.borderWidth = 0.5
    layer.borderColor = UIColor.black.cgColor
    
    face = UILabel(frame:CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    face.textAlignment = .center
    
    addSubview(face)
  }
  
  // MARK: data injection
  var data: Soldier! {
    didSet {
      switch data.side {
      case .none:
        face.text = faceString[0]
      case .p1:
        face.text = faceString[1]
      case .p2:
        face.text = faceString[2]
      }
    }
  }
}
