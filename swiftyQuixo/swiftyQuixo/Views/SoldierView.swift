//
//  SoldierView.swift
//  swiftyQuixo
//
//  Created by 김성종 on 2018. 3. 23..
//  Copyright © 2018년 Willicious-k. All rights reserved.
//

import UIKit

protocol SoldierViewDelegate {
  func selectedCell(_ sender: SoldierView)
}

class SoldierView: UIView {
  let faceString: [String] = [" ","✪","★"]
  
  var delegate: GameViewController?
  
  var face: UILabel!
  var tapRecognizer = UITapGestureRecognizer()
//  var panRecognizer = UIPanGestureRecognizer()
//  var swipeRecognizer = UISwipeGestureRecognizer()
  
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
    
    tapRecognizer.addTarget(self, action: #selector(self.selectCell(_:)))
    
//    panRecognizer.minimumNumberOfTouches = 1
//    panRecognizer.addTarget(self, action: #selector(self.moveCell))
//    swipeRecognizer.direction = .down
//    swipeRecognizer.addTarget(self, action: #selector(self.swipeCell))
    addSubview(face)
  }
  
  // MARK: data injection
  var data: Soldier! {
    didSet {
//      makeActive()
      
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
  func makeActive(player: Soldier.SoldierSide) {
    if isEdge() && (data.side == .none || data.side == player){
      layer.borderColor = UIColor.green.cgColor
      self.backgroundColor = UIColor.green
      
      self.addGestureRecognizer(tapRecognizer)
//      self.addGestureRecognizer(swipeRecognizer)
      // self.removeGestureRecognizer(tapRecognizer)
    }
  }
  
  func isEdge() -> Bool {
    if (data.location.0 == 0 || data.location.0 == 4 || data.location.1 == 0 || data.location.1 == 4) {
      return true
    }
    return false
  }
  
  @objc func selectCell(_ sender: UITapGestureRecognizer) {
    if (data.isSelected == false) {
      self.backgroundColor = .red
      self.data.isSelected = true
    } else {
      self.backgroundColor = .green
      self.data.isSelected = false
    }
    delegate?.selectedCell(self)
  }
  
//  @objc func moveCell(_ sender: UIPanGestureRecognizer) {
//    self.center = self.panRecognizer.location(in: self.superview)
//  }
//
//  @objc func swipeCell(_ sender: UISwipeGestureRecognizer) {
//    self.center = self.swipeRecognizer.location(in: self.superview)
//  }
}
