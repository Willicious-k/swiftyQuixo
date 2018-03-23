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
  var panRecognizer = UIPanGestureRecognizer()
  
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
    
    panRecognizer.minimumNumberOfTouches = 1
    panRecognizer.addTarget(self, action: #selector(self.moveCell))
    
    addSubview(face)
  }
  
  // MARK: data injection
  var data: Soldier! {
    didSet {
      makeActive()
      
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
  
  //MARK: helpers
  func makeActive() {
    if isEdge() {
      layer.borderColor = UIColor.green.cgColor
      self.backgroundColor = UIColor.green
      
      self.addGestureRecognizer(panRecognizer)
      // self.removeGestureRecognizer(tapRecognizer)
    }
  }
  
  func isEdge() -> Bool {
    if (data.location.0 == 0 || data.location.0 == 4 || data.location.1 == 0 || data.location.1 == 4) {
      return true
    }
    return false
  }
  
  @objc func moveCell() {
    self.center = self.panRecognizer.location(in: self.superview)
  }
}
